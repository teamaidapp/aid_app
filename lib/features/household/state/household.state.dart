import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/features/household/entities/household.model.dart';

/// State of the household screen
@immutable
class HouseholdScreenState {
  /// Constructor
  const HouseholdScreenState({
    required this.houseHoldList,
  });

  /// The `copyWith` function returns a new `HouseholdScreenState` object with updated values for the
  /// `houseHoldList` property.
  ///
  /// Args:
  ///   houseHoldList (AsyncValue<List<HouseholdModel>>): An optional asynchronous value that represents
  /// a list of HouseholdModel objects.
  ///
  /// Returns:
  ///   The method is returning a new instance of the `HouseholdScreenState` class with the updated
  /// `houseHoldList` value.
  HouseholdScreenState copyWith({
    AsyncValue<List<HouseholdModel>>? houseHoldList,
  }) {
    return HouseholdScreenState(
      houseHoldList: houseHoldList ?? this.houseHoldList,
    );
  }

  /// The line `final AsyncValue<List<HouseholdModel>> houseHoldList;` is declaring a final variable
  /// named `houseHoldList` of type `AsyncValue<List<HouseholdModel>>`.
  final AsyncValue<List<HouseholdModel>> houseHoldList;
}
