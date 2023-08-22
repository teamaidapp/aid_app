import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/features/home/entities/invitation.model.dart';

/// State of the home screen
@immutable
class HomeScreenState {
  /// Constructor
  const HomeScreenState({
    required this.userTeams,
    required this.invitations,
    required this.allTeams,
  });

  /// The function returns a new instance of HomeScreenState with updated userTeams value if provided,
  /// otherwise it returns the current instance.
  ///
  /// Args:
  ///   userTeams (AsyncValue<List<TeamModel>>): `userTeams` is an optional parameter of type
  /// `AsyncValue<List<TeamModel>>`. It represents the list of teams that a user is a part of and is used
  /// to update the state of the `HomeScreenState` object. The `copyWith` method returns a new
  /// `HomeScreenState`
  ///
  /// Returns:
  ///   The `copyWith` method is returning a new instance of `HomeScreenState` with the same properties as
  /// the current instance, except for the `userTeams` property which is replaced with the new value
  /// passed as an argument to the method. If no new value is passed for `userTeams`, the method returns a
  /// new instance with the same `userTeams` value as the current instance.
  HomeScreenState copyWith({
    AsyncValue<List<TeamModel>>? userTeams,
    AsyncValue<List<TeamModel>>? allTeams,
    AsyncValue<List<InvitationModel>>? invitations,
  }) {
    return HomeScreenState(
      userTeams: userTeams ?? this.userTeams,
      invitations: invitations ?? this.invitations,
      allTeams: allTeams ?? this.allTeams,
    );
  }

  /// The user teams
  final AsyncValue<List<TeamModel>> userTeams;

  /// All teams on the DB
  final AsyncValue<List<TeamModel>> allTeams;

  /// The user invitations
  final AsyncValue<List<InvitationModel>> invitations;
}
