import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/teams/services/teams.service.dart';
import 'package:team_aid/features/teams/state/teams.state.dart';

/// A dependency injection.
final teamsControllerProvider = StateNotifierProvider.autoDispose<TeamsController, TeamsScreenState>((ref) {
  return TeamsController(
    const TeamsScreenState(
      contactList: AsyncValue.data([]),
    ),
    ref,
    ref.watch(teamsServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class TeamsController extends StateNotifier<TeamsScreenState> {
  /// Constructor
  TeamsController(super.state, this.ref, this._teamsService);

  /// Riverpod reference
  final Ref ref;

  final TeamsService _teamsService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getContactList({required String teamId}) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _teamsService.getContactList(teamId: teamId);

      state = state.copyWith(contactList: const AsyncValue.data([]));

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (list) {
          state = state.copyWith(
            contactList: AsyncValue.data(list),
          );
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with TeamsService',
      );
    }
  }

  /// The function `updateInvitation` updates the status of an invitation and returns a
  /// `ResponseFailureModel` indicating the success or failure of the operation.
  ///
  /// Args:
  ///   status (String): The "status" parameter is a required String that represents the updated status of
  /// an invitation. It could be values like "accepted", "rejected", "pending", etc.
  ///   invitationId (String): The `invitationId` parameter is a required String that represents the
  /// unique identifier of the invitation that needs to be updated.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> updateInvitation({
    required String status,
    required String invitationId,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _teamsService.updateInvitation(
        status: status,
        invitationId: invitationId,
      );

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (list) {
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with TeamsService',
      );
    }
  }
}
