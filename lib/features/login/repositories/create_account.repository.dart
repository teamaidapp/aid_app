import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/request_demo.model.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/main.dart';

/// The provider of LoginRepository
final createAccountProvider = Provider<CreateAccountRepository>((ref) {
  final http = ref.watch(httpProvider);
  return CreateAccountRepositoryRepositoryImpl(http);
});

/// This class is responsible of the abstraction
abstract class CreateAccountRepository {
  /// Create Account
  Future<Either<Failure, String>> createAccount({required UserModel user});

  /// Create team
  Future<Either<Failure, String>> createTeam({required TeamModel team});

  /// Request demo
  Future<Either<Failure, Success>> requestDemo({
    required RequestDemoModel demo,
  });
}

/// This class is responsible for implementing the LoginRepository
class CreateAccountRepositoryRepositoryImpl implements CreateAccountRepository {
  /// Constructor
  CreateAccountRepositoryRepositoryImpl(this.http);

  /// The http client
  final Client http;

  /// Get data from backend
  @override
  Future<Either<Failure, String>> createAccount({
    required UserModel user,
  }) async {
    try {
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/users/create-user',
      );
      // final accessToken =
      //     await const FlutterSecureStorage().read(key: TAConstants.accessToken);
      // final headers = <String, String>{
      //   'Content-Type': 'application/json',
      //   'authorization': 'Bearer $accessToken'
      // };

      final res = await http.post(
        url,
        // headers: headers,
        body: user.toMap(),
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'Hubo un error al crear la cuenta',
          ),
        );
      }

      final token =
          (jsonDecode(res.body) as Map<String, dynamic>)['data'] as String;

      return Right(token);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en CreateAccountImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> createTeam({required TeamModel team}) async {
    try {
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/teams/create-team',
      );
      final accessToken =
          await const FlutterSecureStorage().read(key: TAConstants.accessToken);
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken'
      };

      final res = await http.post(
        url,
        headers: headers,
        body: jsonEncode(team.toMap()),
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'An error occurred while creating the team',
          ),
        );
      }

      final token =
          (jsonDecode(res.body) as Map<String, dynamic>)['data'] as String;

      return Right(token);
    } catch (e) {
      return Left(
        Failure(
          message: 'An error occurred on CreateAccountImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> requestDemo({
    required RequestDemoModel demo,
  }) async {
    final url = Uri.parse(
      '${dotenv.env['API_URL']}/waiting-list/create',
    );

    final res = await http.post(
      url,
      body: jsonEncode(demo.toMap()),
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      return Left(
        Failure(
          message: 'An error occurred while creating the demo request',
        ),
      );
    }

    return Right(Success(ok: true, message: ''));
  }
}
