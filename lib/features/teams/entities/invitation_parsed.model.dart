import 'package:team_aid/features/home/entities/invitation.model.dart';

/// A parsed model that we need due to backend response
class ParsedInvitationModel {
  /// Constructor
  const ParsedInvitationModel({
    required this.teamName,
    required this.sport,
    required this.invitation,
  });

  /// The name of the team
  final String teamName;

  /// The sport that the team is
  final String sport;

  /// The model if the invitation
  final Invitation invitation;
}
