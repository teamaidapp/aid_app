// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/myAccount/repositories/myAccount.repository.dart';

/// The provider of MyAccountService
final myAccountServiceProvider = Provider<MyAccountServiceImpl>((ref) {
  final myAccountRepository = ref.watch(myAccountProvider);
  return MyAccountServiceImpl(myAccountRepository);
});

/// This class is responsible of the abstraction
abstract class MyAccountService {
  /// Get data
  Future<Either<Failure, Success>> getData();
}

/// This class is responsible for implementing the MyAccountService
class MyAccountServiceImpl implements MyAccountService {

  /// Constructor
  MyAccountServiceImpl(this.myAccountRepository);

  /// The myAccount Repository that is injected
  final MyAccountRepository myAccountRepository;

  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      final result = await myAccountRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(          
          message: 'Hubo un problema al obtener los datos de MyAccountServiceImpl',
        ),
      );
    }
  }
}
