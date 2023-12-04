import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/home/services/home.service.dart';
import 'package:team_aid/features/home/state/add_player.state.dart';

/// A dependency injection.
final addPlayerControllerProvider = StateNotifierProvider.autoDispose<AddPlayerController, AddPlayerState>((ref) {
  final homeService = ref.watch(homeServiceProvider);
  return AddPlayerController(
    const AddPlayerState(
      listOfPlayers: AsyncValue.data([]),
    ),
    ref,
    homeService,
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class AddPlayerController extends StateNotifier<AddPlayerState> {
  /// Constructor
  AddPlayerController(super.state, this.ref, this._homeService);

  /// Riverpod reference
  final Ref ref;

  final HomeService _homeService;

  /// This function sends a player invitation and returns a response indicating success or failure.
  ///
  /// Args:
  ///   isCoach (bool): A boolean value indicating whether the player invitation is being sent by a coach
  /// or not.
  ///   email (String): The email address of the player or coach being invited to join a team.
  ///   phone (String): A required String parameter representing the phone number of the player or coach
  /// being invited to join a team.
  ///   teamId (String): The ID of the team to which the player invitation is being sent.
  ///
  /// Returns:
  ///   A `Future` of `ResponseFailureModel` is being returned.
  Future<ResponseFailureModel> sendPlayerInvitation({
    required String role,
    required String email,
    required String phone,
    required String teamId,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _homeService.sendPlayerInvitation(
        email: email,
        role: role,
        phone: phone,
        teamId: teamId,
      );

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with HomeService',
      );
    }
  }

  /// This function searches for a player and returns a response indicating success or failure.
  Future<ResponseFailureModel> searchPlayer({
    required String name,
    required String level,
    required String position,
    required String statePlayer,
    required String city,
    required String sport,
    required int page,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _homeService.searchPlayer(
        name: name,
        level: level,
        position: position,
        state: statePlayer,
        city: city,
        sport: sport,
        page: page,
      );

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          state = state.copyWith(listOfPlayers: AsyncValue.data(success));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with HomeService',
      );
    }
  }
}
