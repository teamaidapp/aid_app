
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/travels/services/travels.service.dart';
import 'package:team_aid/features/travels/state/travels.state.dart';

/// A dependency injection.
final travelsControllerProvider = StateNotifierProvider.autoDispose<TravelsController, TravelsScreenState>((ref) {
  return TravelsController(
    const TravelsScreenState(),
    ref,
    ref.watch(travelsServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class TravelsController extends StateNotifier<TravelsScreenState> {
  /// Constructor
  TravelsController(super.state, this.ref, this._travelsService);

  /// Riverpod reference
  final Ref ref;

  final TravelsService _travelsService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getData() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.getData();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {          
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(message: 'Hubo un problema al obtener los datos de TravelsService');
    }
  }
}
