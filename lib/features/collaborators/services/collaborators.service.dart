// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/features/collaborators/entities/collaborator.model.dart';
import 'package:team_aid/features/collaborators/repositories/collaborators.repository.dart';

/// The provider of CollaboratorsService
final collaboratorsServiceProvider = Provider<CollaboratorsServiceImpl>((ref) {
  final collaboratorsRepository = ref.watch(collaboratorsProvider);
  return CollaboratorsServiceImpl(collaboratorsRepository);
});

/// This class is responsible of the abstraction
abstract class CollaboratorsService {
  /// Get data
  Future<Either<Failure, List<CollaboratorModel>>> getData();
}

/// This class is responsible for implementing the CollaboratorsService
class CollaboratorsServiceImpl implements CollaboratorsService {
  /// Constructor
  CollaboratorsServiceImpl(this.collaboratorsRepository);

  /// The collaborators Repository that is injected
  final CollaboratorsRepository collaboratorsRepository;

  @override
  Future<Either<Failure, List<CollaboratorModel>>> getData() async {
    try {
      final result = await collaboratorsRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with CollaboratorsServiceImpl',
        ),
      );
    }
  }
}
