import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/home/services/home.service.dart';
import 'package:team_aid/features/home/state/home.state.dart';

/// A dependency injection.
final homeControllerProvider = StateNotifierProvider.autoDispose<HomeController, HomeScreenState>((ref) {
  return HomeController(
    const HomeScreenState(
      allTeams: AsyncValue.loading(),
      userTeams: AsyncValue.loading(),
      invitations: AsyncValue.loading(),
      organizationTeams: AsyncValue.data([]),
      allOrganizations: AsyncValue.loading(),
    ),
    ref,
    ref.watch(homeServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class HomeController extends StateNotifier<HomeScreenState> {
  /// Constructor
  HomeController(super.state, this.ref, this._homeService);

  /// Riverpod reference
  final Ref ref;

  final HomeService _homeService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getData() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _homeService.getData();

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

  /// This function retrieves a user's teams and updates the state accordingly, returning a response
  /// indicating success or failure.
  ///
  /// Returns:
  ///   a `Future` that resolves to a `ResponseFailureModel`.
  Future<ResponseFailureModel> getUserTeams() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _homeService.getUserTeams();

      return result.fold(
        (failure) {
          state.copyWith(userTeams: const AsyncValue.data([]));
          return response = response.copyWith(message: failure.message);
        },
        (list) {
          state = state.copyWith(userTeams: AsyncValue.data(list));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with HomeService',
      );
    }
  }

  /// The function `getAllTeams` retrieves a list of teams from `_homeService` and updates the state with
  /// the retrieved data, returning a response indicating success or failure.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getAllTeams() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _homeService.getAllTeams();

      return result.fold(
        (failure) {
          state.copyWith(allTeams: const AsyncValue.data([]));
          return response = response.copyWith(message: failure.message);
        },
        (list) {
          state = state.copyWith(allTeams: AsyncValue.data(list));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with HomeService',
      );
    }
  }

  /// The function `getAllOrganizations` retrieves a list of organizations from `_homeService` and updates
  /// the state with the retrieved data, returning a response indicating success or failure.
  /// Returns:
  ///  a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getAllOrganizations() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _homeService.getAllOrganizations();

      return result.fold(
        (failure) {
          state.copyWith(allOrganizations: const AsyncValue.data([]));
          return response = response.copyWith(message: failure.message);
        },
        (list) {
          state = state.copyWith(allOrganizations: AsyncValue.data(list));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with HomeService',
      );
    }
  }

  /// The function `getTeamsByOrganization` retrieves a list of teams from `_homeService` and updates the
  /// state with the retrieved data, returning a response indicating success or failure.
  /// Args:
  ///  organizationId (String): The organization id.
  /// Returns:
  ///  a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getTeamsByOrganization({required String organizationId}) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _homeService.getTeamsByOrganization(organizationId: organizationId);

      return result.fold(
        (failure) {
          state.copyWith(organizationTeams: const AsyncValue.data([]));
          return response = response.copyWith(message: failure.message);
        },
        (list) {
          state = state.copyWith(organizationTeams: AsyncValue.data(list));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with HomeService',
      );
    }
  }

  /// The function `getInvitations` retrieves invitations from the `_homeService` and updates the state
  /// with the retrieved data.
  ///
  /// Args:
  ///   isCoach (bool): A boolean value indicating whether the user is a coach or not.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getInvitations({required bool isCoach}) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _homeService.getInvitations(isCoach: isCoach);

      return result.fold(
        (failure) {
          state = state.copyWith(invitations: const AsyncValue.data([]));
          return response = response.copyWith(message: failure.message);
        },
        (list) {
          state = state.copyWith(invitations: AsyncValue.data(list));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with HomeService',
      );
    }
  }

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
}
