// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/features/teams/entities/contact.model.dart';

/// State of the travels screen
@immutable
class TravelsScreenState {
  /// Constructor
  const TravelsScreenState({
    required this.contactList,
  });

  /// The function returns a new instance of the TravelsScreenState class with updated contactList if
  /// provided, otherwise it returns the current instance.
  ///
  /// Args:
  ///   contactList (AsyncValue<List<ContactModel>>): `contactList` is an optional parameter of type
  /// `AsyncValue<List<ContactModel>>`. It is used in the `copyWith` method of the `TravelsScreenState`
  /// class to create a new instance of the class with updated values. If `contactList` is not provided,
  /// the method
  ///
  /// Returns:
  ///   The `copyWith` method is returning a new instance of `TravelsScreenState` with updated values.
  /// It takes an optional parameter `contactList` of type `AsyncValue<List<ContactModel>>` and returns
  /// a new instance of `TravelsScreenState` with the same values as the current instance, except for
  /// the `contactList` parameter which is updated with the new value if it is
  TravelsScreenState copyWith({
    AsyncValue<List<ContactModel>>? contactList,
  }) {
    return TravelsScreenState(
      contactList: contactList ?? this.contactList,
    );
  }

  /// The contact list
  final AsyncValue<List<ContactModel>> contactList;
}
