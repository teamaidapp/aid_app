import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/core/entities/organization.model.dart';
import 'package:team_aid/core/entities/sent_invitations.model.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/features/home/entities/invitation.model.dart';

/// State of the home screen
@immutable
class HomeScreenState {
  /// Constructor
  const HomeScreenState({
    required this.userTeams,
    required this.allTeams,
    required this.organizationTeams,
    required this.invitations,
    required this.allOrganizations,
    required this.sentInvitations,
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
    AsyncValue<List<TeamModel>>? organizationTeams,
    AsyncValue<List<InvitationModel>>? invitations,
    AsyncValue<List<OrganizationModel>>? allOrganizations,
    AsyncValue<SentInvitationsModel>? sentInvitations,
  }) {
    return HomeScreenState(
      userTeams: userTeams ?? this.userTeams,
      allTeams: allTeams ?? this.allTeams,
      organizationTeams: organizationTeams ?? this.organizationTeams,
      invitations: invitations ?? this.invitations,
      allOrganizations: allOrganizations ?? this.allOrganizations,
      sentInvitations: sentInvitations ?? this.sentInvitations,
    );
  }

  /// The user teams
  final AsyncValue<List<TeamModel>> userTeams;

  /// All teams on the DB
  final AsyncValue<List<TeamModel>> allTeams;

  /// All teams on the DB
  final AsyncValue<List<TeamModel>> organizationTeams;

  /// The user invitations
  final AsyncValue<List<InvitationModel>> invitations;

  /// All organizations on the DB
  final AsyncValue<List<OrganizationModel>> allOrganizations;

  /// The sent invitations
  final AsyncValue<SentInvitationsModel> sentInvitations;
}
