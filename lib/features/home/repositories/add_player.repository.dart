import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/home/entities/player.model.dart';
import 'package:team_aid/main.dart';

/// The provider of AddPlayerRepository
final addPlayerRepositoryProvider = Provider<AddPlayerRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return AddPlayerRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class AddPlayerRepository {
  /// Send player invitation
  Future<Either<Failure, Success>> sendPlayerInvitation({
    required String role,
    required String email,
    required String phone,
    required String teamId,
  });

  /// Search player
  Future<Either<Failure, List<PlayerModel>>> searchPlayer({
    required String name,
    required String level,
    required String position,
    required String state,
    required String city,
    required String sport,
    required int page,
  });
}

/// This class is responsible for implementing the HomeRepository
class AddPlayerRepositoryImpl implements AddPlayerRepository {
  /// Constructor
  AddPlayerRepositoryImpl(this.http, this.secureStorage);

  /// The http client
  final Client http;

  /// The secure storage
  final FlutterSecureStorage secureStorage;

  /// Get data from backend
  @override
  Future<Either<Failure, Success>> sendPlayerInvitation({
    required String role,
    required String email,
    required String phone,
    required String teamId,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/teams/invite-user-by-coach',
      );
      final data = {
        'role': role,
        'email': email,
        'phone': phone,
        'teamId': teamId,
      };
      final res = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (res.statusCode == 409) {
        return Left(
          Failure(
            message: 'The invitation was already sent',
          ),
        );
      }

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error sending the invitation',
          ),
        );
      }

      return Right(Success(ok: true, message: 'Success'));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with HomeRepositoryImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PlayerModel>>> searchPlayer({
    required String name,
    required String level,
    required String position,
    required String state,
    required String city,
    required String sport,
    required int page,
  }) async {
    final list = <PlayerModel>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse('${dotenv.env['API_URL']}/users?limit=50&page=$page'
          '${name.isNotEmpty ? '&name=$name' : ''}'
          '${level.isNotEmpty ? '&level=$level' : ''}'
          '${position.isNotEmpty ? '&position=$position' : ''}'
          '${state.isNotEmpty ? '&state=$state' : ''}'
          '${city.isNotEmpty ? '&city=$city' : ''}'
          '${sport.isNotEmpty ? '&sport=$sport' : ''}');

      final res = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode != 200) {
        return Left(
          Failure(
            message: 'There was an error searching the player',
          ),
        );
      }

      // ignore: avoid_dynamic_calls
      final data = (jsonDecode(res.body) as Map<String, dynamic>)['data']['result'] as List;

      for (final element in data) {
        final player = PlayerModel.fromMap(element as Map<String, dynamic>);
        list.add(player);
      }

      return Right(list);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with HomeRepositoryImpl',
        ),
      );
    }
  }
}
