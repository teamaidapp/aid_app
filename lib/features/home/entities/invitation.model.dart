/// Represents a model for invitations.
class InvitationModel {
  /// Constructs an [InvitationModel] with required parameters.
  const InvitationModel({
    required this.teamId,
    required this.teamName,
    required this.sport,
    required this.invitations,
  });

  /// Creates an [InvitationModel] from a [Map] representation.
  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      teamId: map['teamId'] as String,
      teamName: map['teamName'] as String,
      sport: map['sport'] as String,
      invitations: List<Invitation>.from(
        (map['invitations'] as List).map<Invitation>(
          (x) => Invitation.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// Creates a new [InvitationModel] by copying existing data and updating specified fields.
  InvitationModel copyWith({
    String? teamId,
    String? teamName,
    String? sport,
    List<Invitation>? invitations,
  }) {
    return InvitationModel(
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      sport: sport ?? this.sport,
      invitations: invitations ?? this.invitations,
    );
  }

  /// Converts [InvitationModel] to a [Map] representation.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teamId': teamId,
      'teamName': teamName,
      'sport': sport,
      'invitations': invitations.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'InvitationModel(teamId: $teamId, teamName: $teamName, sport: $sport, invitations: $invitations)';
  }

  /// The teamId of the InvitationModel
  final String teamId;

  /// The teamName of the InvitationModel
  final String teamName;

  /// The sport of the InvitationModel
  final String sport;

  /// The invitations of the InvitationModel
  final List<Invitation> invitations;
}

/// Represents an invitation.
class Invitation {
  /// Constructs an [Invitation] with required parameters.
  const Invitation({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.userId,
    required this.teamId,
  });

  /// Creates an [Invitation] from a [Map] representation.
  factory Invitation.fromMap(Map<String, dynamic> map) {
    return Invitation(
      id: map['id'] as String,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      userId: UserId.fromMap(map['userId'] as Map<String, dynamic>),
      teamId: TeamId.fromMap(map['teamId'] as Map<String, dynamic>),
    );
  }

  /// Creates a new [Invitation] by copying existing data and updating specified fields.
  Invitation copyWith({
    String? id,
    String? status,
    String? createdAt,
    UserId? userId,
    TeamId? teamId,
  }) {
    return Invitation(
      id: id ?? this.id,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      teamId: teamId ?? this.teamId,
    );
  }

  /// Converts [Invitation] to a [Map] representation.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'createdAt': createdAt,
      'userId': userId.toMap(),
      'teamId': teamId.toMap(),
    };
  }

  @override
  String toString() {
    return 'Invitation(id: $id, status: $status, createdAt: $createdAt, userId: $userId, teamId: $teamId)';
  }

  /// The id of the invitation
  final String id;

  /// The status of the invitation
  final String status;

  /// The createdAt of the invitation
  final String createdAt;

  /// The userId of the invitation
  final UserId userId;

  /// The teamId of the invitation
  final TeamId teamId;
}

/// Represents a user ID.
class UserId {
  /// Constructs a [UserId] with required parameters.
  const UserId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  /// Creates a [UserId] from a [Map] representation.
  factory UserId.fromMap(Map<String, dynamic> map) {
    return UserId(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
    );
  }

  /// Creates a new [UserId] by copying existing data and updating specified fields.
  UserId copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return UserId(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }

  /// Converts [UserId] to a [Map] representation.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'UserId(id: $id, firstName: $firstName, lastName: $lastName, email: $email)';
  }

  /// The id of the user
  final String id;

  /// The firstName of the user
  final String firstName;

  /// The lastName of the user
  final String lastName;

  /// The email of the user
  final String email;
}

/// Represents a team ID.
class TeamId {
  /// Constructs a [TeamId] with required parameters.
  const TeamId({
    required this.id,
    required this.teamName,
    required this.sport,
  });

  /// Creates a [TeamId] from a [Map] representation.
  factory TeamId.fromMap(Map<String, dynamic> map) {
    return TeamId(
      id: map['id'] as String,
      teamName: map['teamName'] as String,
      sport: map['sport'] as String,
    );
  }

  /// Creates a new [TeamId] by copying existing data and updating specified fields.
  TeamId copyWith({
    String? id,
    String? teamName,
    String? sport,
  }) {
    return TeamId(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      sport: sport ?? this.sport,
    );
  }

  /// Converts [TeamId] to a [Map] representation.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'teamName': teamName,
      'sport': sport,
    };
  }

  @override
  String toString() {
    return 'TeamId(id: $id, teamName: $teamName, sport: $sport)';
  }

  /// The id of the Team
  final String id;

  /// The teamName of the Team
  final String teamName;

  /// The sport of the Team
  final String sport;
}
