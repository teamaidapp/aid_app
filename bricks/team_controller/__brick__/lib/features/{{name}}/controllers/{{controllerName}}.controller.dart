
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/features/{{name}}/state/{{name}}.state.dart';

/// A dependency injection.
final {{#camelCase}}{{controllerName}} ControllerProvider {{/camelCase}} = StateNotifierProvider.autoDispose<{{#pascalCase}}{{controllerName}} Controller {{/pascalCase}}, {{#pascalCase}}{{name}} ScreenState {{/pascalCase}}>((ref) {
  return {{#pascalCase}}{{controllerName}} Controller {{/pascalCase}}(
    const {{#pascalCase}}{{name}} ScreenState {{/pascalCase}}(),
    ref,
    ref.watch({{#camelCase}}{{name}} ServiceProvider {{/camelCase}}),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class {{#pascalCase}}{{controllerName}} Controller {{/pascalCase}} extends StateNotifier<{{#pascalCase}}{{name}} ScreenState {{/pascalCase}}> {
  /// Constructor
  {{#pascalCase}}{{controllerName}} Controller {{/pascalCase}}(super.state, this.ref);

  /// Riverpod reference
  final Ref ref;

  // final {{#pascalCase}}{{name}} Service {{/pascalCase}} _{{name}}Service;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  // Future<ResponseFailureModel> getData() async {
  //   var response = ResponseFailureModel.defaultFailureResponse();
  //   try {
  //     final result = await _{{name}}Service.getData();

  //     return result.fold(
  //       (failure) => response = response.copyWith(message: failure.message),
  //       (success) {          
  //         return response = response.copyWith(ok: true);
  //       },
  //     );
  //   } catch (e) {
  //     return response = response.copyWith(message: 'Hubo un problema al obtener los datos de {{#pascalCase}}{{name}} Service {{/pascalCase}}');
  //   }
  // }
}
