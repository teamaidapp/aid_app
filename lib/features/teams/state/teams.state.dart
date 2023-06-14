import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/features/teams/entities/contact.model.dart';

/// State of the teams screen
@immutable
class TeamsScreenState {
  /// Constructor
  const TeamsScreenState({
    required this.contactList,
  });

  /// This function returns a new instance of TeamsScreenState with updated contactList if provided,
  /// otherwise it returns the current instance.
  ///
  /// Args:
  ///   contactList (AsyncValue<List<ContactModel>>): `contactList` is an optional parameter of type
  /// `AsyncValue<List<ContactModel>>`. It is used in the `copyWith` method of the `TeamsScreenState`
  /// class to create a new instance of the class with updated values. If a new value for `contactList`
  /// is provided, it
  ///
  /// Returns:
  ///   The `copyWith` method is returning a new instance of `TeamsScreenState` with updated values. It
  /// takes an optional parameter `contactList` of type `AsyncValue<List<ContactModel>>` and returns a
  /// new instance of `TeamsScreenState` with the updated `contactList` value. If `contactList` is not
  /// provided, it returns a new instance of `TeamsScreenState` with the same
  TeamsScreenState copyWith({
    AsyncValue<List<ContactModel>>? contactList,
  }) {
    return TeamsScreenState(
      contactList: contactList ?? this.contactList,
    );
  }

  /// `final AsyncValue<List<ContactModel>> contactList;` is declaring a final variable `contactList` of
  /// type `AsyncValue<List<ContactModel>>`. This variable holds the list of contacts for the teams
  /// screen. `AsyncValue` is a class from the `hooks_riverpod` package that represents an asynchronous
  /// value that can be in one of three states: `Loading`, `Data`, or `Error`. In this case,
  /// `AsyncValue<List<ContactModel>>` represents an asynchronous value that holds a list of
  /// `ContactModel` objects.
  final AsyncValue<List<ContactModel>> contactList;
}
