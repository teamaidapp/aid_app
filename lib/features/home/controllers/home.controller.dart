import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/home/services/home.service.dart';
import 'package:team_aid/features/home/state/home.state.dart';

/// A dependency injection.
final homeControllerProvider =
    StateNotifierProvider<HomeController, HomeScreenState>((ref) {
  return HomeController(
    const HomeScreenState(
      userTeams: AsyncValue.loading(),
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
        message: 'Hubo un problema al obtener los datos de HomeService',
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
        (failure) => response = response.copyWith(message: failure.message),
        (list) {
          state = state.copyWith(userTeams: AsyncValue.data(list));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de HomeService',
      );
    }
  }
}
