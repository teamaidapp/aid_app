// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/core/entities/team.model.dart';
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

  /// Send player invitation
  Future<Either<Failure, Success>> sendPlayerInvitation({
    required bool isCoach,
    required String email,
    required String phone,
    required String teamId,
  });
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
          message: 'Hubo un problema al obtener los datos de HomeServiceImpl',
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
          message: 'Hubo un problema al obtener los datos de HomeServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> sendPlayerInvitation({
    required bool isCoach,
    required String email,
    required String phone,
    required String teamId,
  }) async {
    try {
      final result = await addPlayerRepository.sendPlayerInvitation(
        isCoach: isCoach,
        email: email,
        phone: phone,
        teamId: teamId,
      );

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
