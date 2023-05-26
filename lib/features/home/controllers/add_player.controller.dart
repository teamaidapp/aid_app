import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/features/home/state/home.state.dart';

/// A dependency injection.
final addPlayerControllerProvider =
    StateNotifierProvider.autoDispose<AddPlayerController, HomeScreenState>(
        (ref) {
  return AddPlayerController(
    const HomeScreenState(),
    ref,
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class AddPlayerController extends StateNotifier<HomeScreenState> {
  /// Constructor
  AddPlayerController(super.state, this.ref);

  /// Riverpod reference
  final Ref ref;

  // final HomeService _homeService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  // Future<ResponseFailureModel> getData() async {
  //   var response = ResponseFailureModel.defaultFailureResponse();
  //   try {
  //     final result = await _homeService.getData();

  //     return result.fold(
  //       (failure) => response = response.copyWith(message: failure.message),
  //       (success) {
  //         return response = response.copyWith(ok: true);
  //       },
  //     );
  //   } catch (e) {
  //     return response = response.copyWith(message: 'Hubo un problema al obtener los datos de HomeService');
  //   }
  // }
}
