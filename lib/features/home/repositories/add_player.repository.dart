import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
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
    required bool isCoach,
    required String email,
    required String phone,
    required String teamId,
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
    required bool isCoach,
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
        'isCoach': isCoach,
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

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error sending the invitation',
          ),
        );
      }

      if (res.statusCode == 409) {
        return Left(
          Failure(
            message: 'The invitation was already sent',
          ),
        );
      }

      return Right(Success(ok: true, message: 'Success'));
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en HomeRepositoryImpl',
        ),
      );
    }
  }
}
