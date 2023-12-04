import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/features/collaborators/entities/collaborator.model.dart';

/// State of the collaborators screen
@immutable
class CollaboratorsScreenState {
  /// Constructor
  const CollaboratorsScreenState({
    required this.collaboratorsList,
  });

  /// The `copyWith` function returns a new instance of `CollaboratorsScreenState` with updated values for
  /// the `collaboratorsList` property.
  ///
  /// Args:
  ///   collaboratorsList (AsyncValue<List<CollaboratorModel>>): An optional AsyncValue object that
  /// represents the list of CollaboratorModel objects.
  ///
  /// Returns:
  ///   The `CollaboratorsScreenState` object is being returned.
  CollaboratorsScreenState copyWith({
    AsyncValue<List<CollaboratorModel>>? collaboratorsList,
  }) {
    return CollaboratorsScreenState(
      collaboratorsList: collaboratorsList ?? this.collaboratorsList,
    );
  }

  /// The line `AsyncValue<List<CollaboratorModel>> collaboratorsList;` is declaring a property named
  /// `collaboratorsList` of type `AsyncValue<List<CollaboratorModel>>`.
  final AsyncValue<List<CollaboratorModel>> collaboratorsList;
}
