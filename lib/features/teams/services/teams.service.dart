// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/teams/entities/contact.model.dart';
import 'package:team_aid/features/teams/repositories/teams.repository.dart';

/// The provider of TeamsService
final teamsServiceProvider = Provider<TeamsServiceImpl>((ref) {
  final teamsRepository = ref.watch(teamsProvider);
  return TeamsServiceImpl(teamsRepository);
});

/// This class is responsible of the abstraction
abstract class TeamsService {
  /// Get data
  Future<Either<Failure, List<ContactModel>>> getContactList({
    required String teamId,
  });

  /// Update the invitation status
  Future<Either<Failure, Success>> updateInvitation({
    required String status,
    required String invitationId,
  });
}

/// This class is responsible for implementing the TeamsService
class TeamsServiceImpl implements TeamsService {
  /// Constructor
  TeamsServiceImpl(this.teamsRepository);

  /// The teams Repository that is injected
  final TeamsRepository teamsRepository;

  @override
  Future<Either<Failure, List<ContactModel>>> getContactList({
    required String teamId,
  }) async {
    try {
      final result = await teamsRepository.getContactList(teamId: teamId);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TeamsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> updateInvitation({
    required String status,
    required String invitationId,
  }) async {
    try {
      final result = await teamsRepository.updateInvitation(
        invitationId: invitationId,
        status: status,
      );

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error on TeamsServiceImpl',
        ),
      );
    }
  }
}
