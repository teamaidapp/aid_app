import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/login/services/login.service.dart';
import 'package:team_aid/features/login/state/login.state.dart';

/// A dependency injection.
final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginScreenState>((ref) {
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

  /// Login
  Future<ResponseFailureModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _loginService.login(
        email: email,
        password: password,
      );

      return res.fold(
        (l) => ResponseFailureModel(ok: false, message: l.message),
        (r) => ResponseFailureModel(ok: true, message: r.message),
      );
    } catch (e) {
      return ResponseFailureModel(
        ok: false,
        message: 'An unexpected error occurred',
      );
    }
  }
}
