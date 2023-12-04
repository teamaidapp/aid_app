// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/household/entities/household.model.dart';
import 'package:team_aid/features/household/repositories/household.repository.dart';

/// The provider of HouseholdService
final householdServiceProvider = Provider<HouseholdServiceImpl>((ref) {
  final householdRepository = ref.watch(householdProvider);
  return HouseholdServiceImpl(householdRepository);
});

/// This class is responsible of the abstraction
abstract class HouseholdService {
  /// Get data
  Future<Either<Failure, List<HouseholdModel>>> getHouseholds();

  /// The `deleteHousehold` method in the `HouseholdService` class is responsible for deleting a
  /// household based on its ID. It returns a `Future` that will either resolve to an `Either`
  /// containing a `Failure` or a `Success` object.
  Future<Either<Failure, Success>> deleteHousehold({required String id});
}

/// This class is responsible for implementing the HouseholdService
class HouseholdServiceImpl implements HouseholdService {
  /// Constructor
  HouseholdServiceImpl(this.householdRepository);

  /// The household Repository that is injected
  final HouseholdRepository householdRepository;

  @override
  Future<Either<Failure, List<HouseholdModel>>> getHouseholds() async {
    try {
      final result = await householdRepository.getHouseholds();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HouseholdServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> deleteHousehold({required String id}) async {
    try {
      final result = await householdRepository.deleteHousehold(id: id);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un problema al eliminar el HouseholdServiceImpl',
        ),
      );
    }
  }
}
