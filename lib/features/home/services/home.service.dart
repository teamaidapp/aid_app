// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/home/repositories/home.repository.dart';

/// The provider of HomeService
final homeServiceProvider = Provider<HomeServiceImpl>((ref) {
  final homeRepository = ref.watch(homeProvider);
  return HomeServiceImpl(homeRepository);
});

/// This class is responsible of the abstraction
abstract class HomeService {
  /// Get data
  Future<Either<Failure, Success>> getData();
}

/// This class is responsible for implementing the HomeService
class HomeServiceImpl implements HomeService {

  /// Constructor
  HomeServiceImpl(this.homeRepository);

  /// The home Repository that is injected
  final HomeRepository homeRepository;

  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      final result = await homeRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(          
          message: 'Hubo un problema al obtener los datos de HomeServiceImpl',
        ),
      );
    }
  }
}
