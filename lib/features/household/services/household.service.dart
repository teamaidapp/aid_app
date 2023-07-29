// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/household/repositories/household.repository.dart';

/// The provider of HouseholdService
final householdServiceProvider = Provider<HouseholdServiceImpl>((ref) {
  final householdRepository = ref.watch(householdProvider);
  return HouseholdServiceImpl(householdRepository);
});

/// This class is responsible of the abstraction
abstract class HouseholdService {
  /// Get data
  Future<Either<Failure, Success>> getData();
}

/// This class is responsible for implementing the HouseholdService
class HouseholdServiceImpl implements HouseholdService {

  /// Constructor
  HouseholdServiceImpl(this.householdRepository);

  /// The household Repository that is injected
  final HouseholdRepository householdRepository;

  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      final result = await householdRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(          
          message: 'Hubo un problema al obtener los datos de HouseholdServiceImpl',
        ),
      );
    }
  }
}
