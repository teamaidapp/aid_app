import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/features/myAccount/services/myAccount.service.dart';
import 'package:team_aid/features/myAccount/state/myAccount.state.dart';

/// A dependency injection.
final myAccountControllerProvider = StateNotifierProvider.autoDispose<MyAccountController, MyAccountScreenState>((ref) {
  return MyAccountController(
    const MyAccountScreenState(),
    ref,
    ref.watch(myAccountServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class MyAccountController extends StateNotifier<MyAccountScreenState> {
  /// Constructor
  MyAccountController(super.state, this.ref, this._myAccountService);

  /// Riverpod reference
  final Ref ref;

  final MyAccountService _myAccountService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getData() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _myAccountService.getData();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(message: 'Hubo un problema al obtener los datos de MyAccountService');
    }
  }

  /// This function creates a team by calling the `_myAccountService.createAccount` method with a
  /// user object and returns a `ResponseFailureModel` object indicating success or failure.
  Future<ResponseFailureModel> updateUserData({
    required UserModel user,
    required String uid,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _myAccountService.updateUserData(user: user, uid: uid);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de CreateAccountService',
      );
    }
  }
}
