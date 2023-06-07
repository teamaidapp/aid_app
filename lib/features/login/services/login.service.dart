// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/login/repositories/login.repository.dart';

/// The provider of LoginService
final loginServiceProvider = Provider<LoginServiceImpl>((ref) {
  final loginRepository = ref.watch(loginProvider);
  return LoginServiceImpl(loginRepository);
});

/// This class is responsible of the abstraction
abstract class LoginService {
  /// Get data
  Future<Either<Failure, Success>> login({
    required String email,
    required String password,
  });
}

/// This class is responsible for implementing the LoginService
class LoginServiceImpl implements LoginService {
  /// Constructor
  LoginServiceImpl(this.loginRepository);

  /// The login Repository that is injected
  final LoginRepository loginRepository;

  @override
  Future<Either<Failure, Success>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await loginRepository.login(email: email, password: password);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un problema al obtener los datos de LoginServiceImpl',
        ),
      );
    }
  }
}
