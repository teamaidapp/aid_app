// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/organization.model.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/features/home/entities/invitation.model.dart';
import 'package:team_aid/features/home/entities/player.model.dart';
import 'package:team_aid/features/home/repositories/add_player.repository.dart';
import 'package:team_aid/features/home/repositories/home.repository.dart';

/// The provider of HomeService
final homeServiceProvider = Provider<HomeServiceImpl>((ref) {
  final homeRepository = ref.watch(homeProvider);
  final addPlayerRepository = ref.watch(addPlayerRepositoryProvider);
  return HomeServiceImpl(homeRepository, addPlayerRepository);
});

/// This class is responsible of the abstraction
abstract class HomeService {
  /// Get data
  Future<Either<Failure, Success>> getData();

  /// Get user teams
  Future<Either<Failure, List<TeamModel>>> getUserTeams();

  /// Get all teams
  Future<Either<Failure, List<TeamModel>>> getAllTeams();

  /// Get teams by organization
  Future<Either<Failure, List<TeamModel>>> getTeamsByOrganization({required String organizationId});

  /// Send player invitation
  Future<Either<Failure, Success>> sendPlayerInvitation({
    required String role,
    required String email,
    required String phone,
    required String teamId,
  });

  /// Search player
  Future<Either<Failure, List<PlayerModel>>> searchPlayer({
    required String name,
    required String level,
    required String position,
    required String state,
    required String city,
    required String sport,
    required int page,
  });

  /// Get the invitations from the given boolean
  Future<Either<Failure, List<InvitationModel>>> getInvitations({required bool isCoach});

  /// Get all organizations
  Future<Either<Failure, List<OrganizationModel>>> getAllOrganizations();
}

/// This class is responsible for implementing the HomeService
class HomeServiceImpl implements HomeService {
  /// Constructor
  HomeServiceImpl(this.homeRepository, this.addPlayerRepository);

  /// The home Repository that is injected
  final HomeRepository homeRepository;

  /// The add player Repository that is injected
  final AddPlayerRepository addPlayerRepository;

  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      final result = await homeRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HomeServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TeamModel>>> getUserTeams() async {
    try {
      final result = await homeRepository.getUserTeams();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HomeServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TeamModel>>> getAllTeams() async {
    try {
      final result = await homeRepository.getAllTeams();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HomeServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> sendPlayerInvitation({
    required String role,
    required String email,
    required String phone,
    required String teamId,
  }) async {
    try {
      final result = await addPlayerRepository.sendPlayerInvitation(
        role: role,
        email: email,
        phone: phone,
        teamId: teamId,
      );

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HomeServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PlayerModel>>> searchPlayer({
    required String name,
    required String level,
    required String position,
    required String state,
    required String city,
    required String sport,
    required int page,
  }) async {
    try {
      final result = await addPlayerRepository.searchPlayer(
        name: name,
        level: level,
        position: position,
        state: state,
        city: city,
        sport: sport,
        page: page,
      );

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HomeServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<InvitationModel>>> getInvitations({required bool isCoach}) async {
    try {
      final result = await homeRepository.getInvitations(isCoach: isCoach);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HomeServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TeamModel>>> getTeamsByOrganization({required String organizationId}) async {
    try {
      final result = await homeRepository.getTeamsByOrganization(organizationId: organizationId);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HomeServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<OrganizationModel>>> getAllOrganizations() async {
    try {
      final result = await homeRepository.getAllOrganizations();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with HomeServiceImpl',
        ),
      );
    }
  }
}
