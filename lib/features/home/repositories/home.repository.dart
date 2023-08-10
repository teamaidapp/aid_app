import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/features/home/entities/invitation.model.dart';
import 'package:team_aid/main.dart';

/// The provider of HomeRepository
final homeProvider = Provider<HomeRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return HomeRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class HomeRepository {
  /// Get data
  Future<Either<Failure, Success>> getData();

  /// Get user teams
  Future<Either<Failure, List<TeamModel>>> getUserTeams();

  /// Get the invitations from the given boolean
  Future<Either<Failure, List<InvitationModel>>> getInvitations({required bool isCoach});
}

/// This class is responsible for implementing the HomeRepository
class HomeRepositoryImpl implements HomeRepository {
  /// Constructor
  HomeRepositoryImpl(this.http, this.secureStorage);

  /// The http client
  final Client http;

  /// The secure storage
  final FlutterSecureStorage secureStorage;

  /// Get data from backend
  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      return Right(Success(ok: true, message: 'Success'));
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en HomeRepositoryImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TeamModel>>> getUserTeams() async {
    final teams = <TeamModel>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/teams/teams-by-user',
      );
      final res = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final data = (jsonDecode(res.body) as Map)['data'] as List;

      for (final element in data) {
        final team = TeamModel.fromMap(element as Map<String, dynamic>);
        teams.add(team);
      }
      return Right(teams);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en HomeRepositoryImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<InvitationModel>>> getInvitations({
    required bool isCoach,
  }) async {
    final invitations = <InvitationModel>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/teams/invitations-by-coach',
      );
      final res = await http.get(url, headers: {'Authorization': 'Bearer $token'});

      final data = (jsonDecode(res.body) as Map)['data'] as List;

      for (final element in data) {
        final invitation = InvitationModel.fromMap(element as Map<String, dynamic>);
        invitations.add(invitation);
      }
      return Right(invitations);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en HomeRepositoryImpl',
        ),
      );
    }
  }
}
