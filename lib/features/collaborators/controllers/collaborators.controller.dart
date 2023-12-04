import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/collaborators/services/collaborators.service.dart';
import 'package:team_aid/features/collaborators/state/collaborators.state.dart';

/// A dependency injection.
final collaboratorsControllerProvider = StateNotifierProvider.autoDispose<CollaboratorsController, CollaboratorsScreenState>((ref) {
  return CollaboratorsController(
    const CollaboratorsScreenState(
      collaboratorsList: AsyncValue.loading(),
    ),
    ref,
    ref.watch(collaboratorsServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class CollaboratorsController extends StateNotifier<CollaboratorsScreenState> {
  /// Constructor
  CollaboratorsController(super.state, this.ref, this._collaboratorsService);

  /// Riverpod reference
  final Ref ref;

  final CollaboratorsService _collaboratorsService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getData() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _collaboratorsService.getData();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          state = state.copyWith(collaboratorsList: AsyncValue.data(success));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(message: 'There was a problem with CollaboratorsService');
    }
  }
}
