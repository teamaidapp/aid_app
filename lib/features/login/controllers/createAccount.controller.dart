import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/request_demo.model.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/features/login/services/create_account.service.dart';

/// A dependency injection.
final createAccountControllerProvider = StateNotifierProvider.autoDispose<CreateAccountController, void>((ref) {
  return CreateAccountController(
    ref,
    ref.watch(createAccountServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class CreateAccountController extends StateNotifier<void> {
  /// Constructor
  CreateAccountController(this.ref, this._createAccountService) : super(null);

  /// Riverpod reference
  final Ref ref;

  final CreateAccountService _createAccountService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> createAccount({required UserModel user}) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _createAccountService.createAccount(user: user);

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

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> createChildAccount({required UserModel user}) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _createAccountService.createChildAccount(user: user);

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

  /// This function creates a team by calling the `_createAccountService.createAccount` method with a
  /// user object and returns a `ResponseFailureModel` object indicating success or failure.
  ///
  /// Args:
  ///   user (UserModel): The `user` parameter is a required `UserModel` object that contains
  /// information about a user, such as their name, email, and password. This parameter is used in the
  /// `_createAccountService.createAccount` method to create a new user account.
  ///
  /// Returns:
  ///   a `Future` that resolves to a `ResponseFailureModel` object.
  Future<ResponseFailureModel> createTeam({required TeamModel team}) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _createAccountService.createTeam(team: team);

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

  /// This function sends a request for a demo and returns a response indicating success or failure.
  ///
  /// Args:
  ///   demo (RequestDemoModel): A required parameter of type RequestDemoModel that is used as input for
  /// the requestDemo method. It is likely used to provide information needed to create a demo account.
  ///
  /// Returns:
  ///   a `Future` that resolves to a `ResponseFailureModel` object.
  Future<ResponseFailureModel> requestDemo({
    required RequestDemoModel demo,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _createAccountService.requestDemo(demo: demo);

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
