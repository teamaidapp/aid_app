import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/teams/services/teams.service.dart';
import 'package:team_aid/features/teams/state/teams.state.dart';

/// A dependency injection.
final teamsControllerProvider =
    StateNotifierProvider.autoDispose<TeamsController, TeamsScreenState>((ref) {
  return TeamsController(
    const TeamsScreenState(
      contactList: AsyncValue.loading(),
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

      state = state.copyWith(contactList: const AsyncValue.loading());

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
        message: 'Hubo un problema al obtener los datos de TeamsService',
      );
    }
  }
}
