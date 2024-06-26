// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
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

  /// Send email to reset password
  Future<Either<Failure, Success>> sendForgotEmail({
    required String email,
  });

  /// Recover password
  Future<Either<Failure, Success>> recoverPassword({
    required String email,
    required String otp,
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
      final result = await loginRepository.login(email: email, password: password);

      return result.fold(
        Left.new,
        (r) async {
          await GlobalFunctions().saveUserSession(
            user: UserModel(
              email: email,
              password: '',
              biography: r['biography'] as String? ?? '',
              firstName: r['firstName'] as String,
              lastName: r['lastName'] as String,
              phoneNumber: r['phoneNumber'] as String,
              isAvatarVisible: r['isAvatarVisible'] as bool,
              isBiographyVisible: r['isBiographyVisible'] as bool,
              isEmailVisible: r['isEmailVisible'] as bool,
              isFatherVisible: r['isFatherVisible'] as bool,
              isPhoneVisible: r['isPhoneVisible'] as bool,
              sportId: '',
              cityId: '',
              stateId: '',
              avatar: r['avatar'] as String? ?? '',
              role: Role.values.firstWhere(
                (e) => e.toString() == 'Role.${r['role'] as String}',
              ),
            ),
            token: r['accessToken'] as String,
          );
          return Right(
            Success(
              ok: true,
              message: '',
            ),
          );
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with LoginServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> recoverPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    try {
      final result = await loginRepository.recoverPassword(
        email: email,
        otp: otp,
        password: password,
      );

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with LoginServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> sendForgotEmail({
    required String email,
  }) async {
    try {
      final result = await loginRepository.sendForgotEmail(email: email);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with LoginServiceImpl',
        ),
      );
    }
  }
}
