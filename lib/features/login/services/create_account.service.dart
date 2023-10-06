// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/request_demo.model.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/login/repositories/create_account.repository.dart';

/// The provider of LoginService
final createAccountServiceProvider = Provider<CreateAccountServiceImpl>((ref) {
  final createAccount = ref.watch(createAccountProvider);
  return CreateAccountServiceImpl(createAccount);
});

/// This class is responsible of the abstraction
abstract class CreateAccountService {
  /// Create account
  Future<Either<Failure, Success>> createAccount({required UserModel user});

  /// Create child account
  Future<Either<Failure, Success>> createChildAccount({required UserModel user});

  /// Create team
  Future<Either<Failure, String>> createTeam({required TeamModel team});

  /// Request demo
  Future<Either<Failure, Success>> requestDemo({
    required RequestDemoModel demo,
  });
}

/// This class is responsible for implementing the LoginService
class CreateAccountServiceImpl implements CreateAccountService {
  /// Constructor
  CreateAccountServiceImpl(this.createAccountRepository);

  /// The login Repository that is injected
  final CreateAccountRepository createAccountRepository;

  @override
  Future<Either<Failure, Success>> createAccount({
    required UserModel user,
  }) async {
    try {
      final result = await createAccountRepository.createAccount(user: user);

      final token = result.getOrElse(() => '');

      await GlobalFunctions().saveUserSession(user: user, token: token);

      return result.fold(
        (failure) => Left(
          Failure(
            message: failure.message,
          ),
        ),
        (success) => Right(
          Success(
            ok: true,
            message: '',
          ),
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'An error ocurred on CreateAccountServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> createChildAccount({
    required UserModel user,
  }) async {
    try {
      final result = await createAccountRepository.createChildAccount(user: user);

      return result.fold(
        (failure) => Left(
          Failure(
            message: failure.message,
          ),
        ),
        (success) => Right(
          Success(
            ok: true,
            message: '',
          ),
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'An error ocurred on CreateAccountServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> createTeam({required TeamModel team}) async {
    try {
      final result = await createAccountRepository.createTeam(team: team);

      return result.fold(
        (failure) => Left(
          Failure(
            message: failure.message,
          ),
        ),
        Right.new,
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'An error ocurred on CreateAccountServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> requestDemo({
    required RequestDemoModel demo,
  }) async {
    try {
      final result = await createAccountRepository.requestDemo(demo: demo);

      return result.fold(
        (failure) => Left(
          Failure(
            message: failure.message,
          ),
        ),
        (success) => Right(
          Success(
            ok: true,
            message: '',
          ),
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'An error ocurred on CreateAccountServiceImpl',
        ),
      );
    }
  }
}
