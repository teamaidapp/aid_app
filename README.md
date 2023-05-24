# Team Aid Project


### Structure:

We are using the Folder-by-feature structure and you can learn more about it and other ways of doing folder structure here: https://www.youtube.com/watch?v=yJRpuTP156o

```
lib/
  core/
    models/
      user_model.dart
    services/
      user_service.dart
    utils/
      constants.dart
  features/
    feature_1/
      controllers/
        feature_1_controller.dart
      models/
        feature_1_model.dart
      repositories/
        feature_1_repository.dart
      services/
        feature_1_service.dart
      state/
        feature_1_state.dart
      feature_1_screen.dart
    feature_2/
      controllers/
        feature_2_controller.dart
      models/
        feature_2_model.dart
      repositories/
        feature_2_repository.dart
      services/
        feature_2_service.dart
      state/
        feature_2_state.dart
      feature_2_screen.dart
    common/
      widgets/
        custom_button.dart
      utils/
        date_utils.dart
```

You can generate a new feature with the brick called 'feature', the only requirment is to install the [mason_cli](https://pub.dev/packages/mason_cli) and run the following command inside the project:

```
mason make team_feature
```

The prompt will ask you to type the feature name, and that's it, you will have auto-generated the new feature.


### The Repository-Service Pattern

This pattern breaks up the business layer of the app into two distinct layers, you can find more information about this pattern [here](https://exceptionnotfound.net/the-repository-service-pattern-with-dependency-injection-and-asp-net-core/).
