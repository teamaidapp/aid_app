// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/travels/repositories/travels.repository.dart';

/// The provider of TravelsService
final travelsServiceProvider = Provider<TravelsServiceImpl>((ref) {
  final travelsRepository = ref.watch(travelsProvider);
  return TravelsServiceImpl(travelsRepository);
});

/// This class is responsible of the abstraction
abstract class TravelsService {
  /// Get data
  Future<Either<Failure, Success>> getData();
}

/// This class is responsible for implementing the TravelsService
class TravelsServiceImpl implements TravelsService {

  /// Constructor
  TravelsServiceImpl(this.travelsRepository);

  /// The travels Repository that is injected
  final TravelsRepository travelsRepository;

  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      final result = await travelsRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(          
          message: 'Hubo un problema al obtener los datos de TravelsServiceImpl',
        ),
      );
    }
  }
}
