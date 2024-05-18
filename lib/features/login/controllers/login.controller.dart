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

  /// The function `sendForgotEmail` sends a forgot email using the provided email address and handles
  /// response errors.
  ///
  /// Args:
  ///   email (String): The `sendForgotEmail` function takes an email address as a parameter. This email
  /// address is used to send a forgot password email to the user. If the email sending process is
  /// successful, it returns a `ResponseFailureModel` with a success message. If there is an error during
  /// the process,
  ///
  /// Returns:
  ///   The function `sendForgotEmail` returns a `Future` that resolves to a `ResponseFailureModel`.
  Future<ResponseFailureModel> sendForgotEmail({
    required String email,
  }) async {
    try {
      final res = await _loginService.sendForgotEmail(email: email);

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

  /// This Dart function `recoverPassword` attempts to recover a user's password using provided email,
  /// OTP, and new password, handling potential errors and returning a `ResponseFailureModel`.
  ///
  /// Args:
  ///   email (String): The `email` parameter is a required `String` that represents the email address of
  /// the user who is trying to recover their password.
  ///   otp (String): One-Time Password (OTP) is a unique code that is generated and sent to a user's
  /// mobile phone or email address for authentication purposes. It is typically used as an additional
  /// layer of security to verify the identity of the user during password recovery or account login
  /// processes.
  ///   password (String): The `password` parameter in the `recoverPassword` function represents the new
  /// password that the user wants to set for their account. This password will be used to replace the
  /// current password associated with the user's email address during the password recovery process.
  ///
  /// Returns:
  ///   The `recoverPassword` function returns a `Future` that resolves to a `ResponseFailureModel`.
  Future<ResponseFailureModel> recoverPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    try {
      final res = await _loginService.recoverPassword(email: email, otp: otp, password: password);

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
