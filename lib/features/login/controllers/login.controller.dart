
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/login/services/login.service.dart';
import 'package:team_aid/features/login/state/login.state.dart';

/// A dependency injection.
final loginControllerProvider = StateNotifierProvider.autoDispose<LoginController, LoginScreenState>((ref) {
  return LoginController(
    const LoginScreenState(),
    ref,
    ref.watch(loginServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class LoginController extends StateNotifier<LoginScreenState> {
  /// Constructor
  LoginController(super.state, this.ref, this._loginService);

  /// Riverpod reference
  final Ref ref;

  final LoginService _loginService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getData() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _loginService.getData();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {          
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(message: 'Hubo un problema al obtener los datos de LoginService');
    }
  }
}
