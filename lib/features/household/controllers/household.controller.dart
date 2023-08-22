import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/household/services/household.service.dart';
import 'package:team_aid/features/household/state/household.state.dart';

/// A dependency injection.
final householdControllerProvider = StateNotifierProvider.autoDispose<HouseholdController, HouseholdScreenState>((ref) {
  return HouseholdController(
    const HouseholdScreenState(
      houseHoldList: AsyncValue.loading(),
    ),
    ref,
    ref.watch(householdServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class HouseholdController extends StateNotifier<HouseholdScreenState> {
  /// Constructor
  HouseholdController(super.state, this.ref, this._householdService);

  /// Riverpod reference
  final Ref ref;

  final HouseholdService _householdService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getData() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _householdService.getHouseholds();

      return result.fold(
        (failure) {
          state = state.copyWith(houseHoldList: const AsyncValue.data([]));
          return response = response.copyWith(message: failure.message);
        },
        (success) {
          state = state.copyWith(houseHoldList: AsyncValue.data(success));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(message: 'Hubo un problema al obtener los datos de HouseholdService');
    }
  }
}
