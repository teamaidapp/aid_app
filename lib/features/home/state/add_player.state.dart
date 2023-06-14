import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/features/home/entities/player.model.dart';

/// Handles the state of the AddPlayerScreen
@immutable
class AddPlayerState {
  /// Constructor
  const AddPlayerState({
    required this.listOfPlayers,
  });

  /// The function returns a new instance of AddPlayerState with updated listOfPlayers if provided,
  /// otherwise it returns the current instance.
  ///
  /// Args:
  ///   listOfPlayers (AsyncValue<List<PlayerModel>>): A nullable AsyncValue object that contains a list
  /// of PlayerModel objects. This parameter is used in the copyWith method of the AddPlayerState class to
  /// create a new instance of the class with updated values. If the parameter is not provided, the method
  /// will use the current value of the listOfPlayers property
  ///
  /// Returns:
  ///   The `copyWith` method is returning a new instance of the `AddPlayerState` class with updated
  /// values. If `listOfPlayers` is not null, it will be used as the new value for `listOfPlayers`,
  /// otherwise the existing value of `listOfPlayers` will be used.
  AddPlayerState copyWith({
    AsyncValue<List<PlayerModel>>? listOfPlayers,
  }) {
    return AddPlayerState(
      listOfPlayers: listOfPlayers ?? this.listOfPlayers,
    );
  }

  /// `listOfPlayers` is a final variable of type `AsyncValue<List<PlayerModel>>`. It is a property of
  /// the `AddPlayerState` class and represents the list of players that is being managed by this state.
  /// `AsyncValue` is a class from the `hooks_riverpod` package that represents an asynchronous value
  /// that can be in one of three states: `Loading`, `Data`, or `Error`. In this case, it is used to
  /// represent the state of the list of players, which can be loading, have data, or have an error.
  final AsyncValue<List<PlayerModel>> listOfPlayers;
}
