// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/main.dart';

/// The provider of LoginRepository
final loginProvider = Provider<LoginRepository>((ref) {
  final http = ref.watch(httpProvider);
  return LoginRepositoryImpl(http);
});

/// This class is responsible of the abstraction
abstract class LoginRepository {
  /// Get data
  Future<Either<Failure, Success>> login({
    required String email,
    required String password,
  });
}

/// This class is responsible for implementing the LoginRepository
class LoginRepositoryImpl implements LoginRepository {
  /// Constructor
  LoginRepositoryImpl(this.http);

  /// The http client
  final Client http;

  /// Get data from backend
  @override
  Future<Either<Failure, Success>> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/auth/login',
      );

      final res = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'Hubo un error al iniciar sesión',
          ),
        );
      }
      return Right(Success(ok: true, message: 'Success'));
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en LoginRepositoyImpl',
        ),
      );
    }
  }
}
