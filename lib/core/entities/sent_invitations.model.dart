/// The model for sent invitations
class SentInvitationsModel {
  /// Constructs a [SentInvitationsModel] with required parameters.
  const SentInvitationsModel({
    required this.registeredUsers,
    required this.noRegisteredUsers,
  });

  /// The factory method `SentInvitationsModel.fromMap` converts a map into a `SentInvitationsModel`
  /// object by mapping lists of `RegisteredUser` and `NoRegisteredUser` objects.ing
  /// lists of integers in the `map`. Each integer is being converted to a `RegisteredUser` or
  factory SentInvitationsModel.fromMap(Map<String, dynamic> map) {
    return SentInvitationsModel(
      registeredUsers: List<RegisteredUser>.from(
        (map['registeredUsers'] as List<dynamic>).map(
          (x) => RegisteredUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
      noRegisteredUsers: List<NoRegisteredUser>.from(
        (map['noRegisteredUsers'] as List<dynamic>).map(
          (x) => NoRegisteredUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// The `copyWith` function in Dart creates a new instance of `SentInvitationsModel` with updated values
  /// for `registeredUsers` and `noRegisteredUsers`.
  SentInvitationsModel copyWith({
    List<RegisteredUser>? registeredUsers,
    List<NoRegisteredUser>? noRegisteredUsers,
  }) {
    return SentInvitationsModel(
      registeredUsers: registeredUsers ?? this.registeredUsers,
      noRegisteredUsers: noRegisteredUsers ?? this.noRegisteredUsers,
    );
  }

  /// The `toMap` function converts a Dart object into a map with registered users and their details.
  ///
  /// Returns:
  ///   A Map<String, dynamic> is being returned. The map contains two key-value pairs:
  /// 1. Key 'registeredUsers' with value as a list of maps generated by calling the toMap() method on
  /// each element in the registeredUsers list.
  /// 2. Key 'noRegisteredUsers' with value as a list of maps generated by calling the toMap() method on
  /// each element in the noRegisteredUsers
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registeredUsers': registeredUsers.map((x) => x.toMap()).toList(),
      'noRegisteredUsers': noRegisteredUsers.map((x) => x.toMap()).toList(),
    };
  }

  /// A list of registered users who have been invited to join a team.
  final List<RegisteredUser> registeredUsers;

  /// A list of users who have not registered on the app for an invitation.
  final List<NoRegisteredUser> noRegisteredUsers;
}

/// Represents a registered user who has been invited to join a team.
class RegisteredUser {
  /// Constructs a [RegisteredUser] with required parameters.
  const RegisteredUser({
    required this.id,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updateAt,
    required this.teamId,
  });

  /// The factory method `RegisteredUser.fromMap` creates a `RegisteredUser` object from a map of key-value
  factory RegisteredUser.fromMap(Map<String, dynamic> map) {
    return RegisteredUser(
      id: map['id'] as String,
      role: map['role'] as String,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
      teamId: TeamId.fromMap(map['teamId'] as Map<String, dynamic>),
    );
  }

  /// The `copyWith` function in Dart is used to create a new instance of an object with updated values
  RegisteredUser copyWith({
    String? id,
    String? role,
    String? status,
    String? createdAt,
    String? updateAt,
    TeamId? teamId,
  }) {
    return RegisteredUser(
      id: id ?? this.id,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      teamId: teamId ?? this.teamId,
    );
  }

  /// Converts the RegisteredUser object to a map of key-value pairs.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'role': role,
      'status': status,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'teamId': teamId.toMap(),
    };
  }

  /// The id of the registered user
  final String id;

  /// The role of the registered user
  final String role;

  /// The status of the registered user
  final String status;

  /// The createdAt of the registered user
  final String createdAt;

  /// The updateAt of the registered user
  final String updateAt;

  /// The teamId of the registered user
  final TeamId teamId;
}

/// Represents a team ID.
class TeamId {
  /// Constructs a [TeamId] with required parameters.
  const TeamId({
    required this.id,
    required this.teamName,
    required this.sport,
    required this.gender,
    required this.organization,
    required this.country,
    required this.zipCode,
    required this.state,
    required this.city,
    required this.level,
    required this.createdAt,
    required this.updateAt,
  });

  /// The factory method `TeamId.fromMap` creates a `TeamId` object from a map of key-value pairs.
  factory TeamId.fromMap(Map<String, dynamic> map) {
    return TeamId(
      id: map['id'] as String,
      teamName: map['teamName'] as String,
      sport: map['sport'] as String,
      gender: map['gender'] as String,
      organization: map['organization'] as String? ?? '',
      country: map['country'] as String? ?? '',
      zipCode: map['zipCode'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      level: map['level'] as String? ?? '',
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
    );
  }

  /// The `copyWith` function in Dart is used to create a new instance of an object with updated values
  /// while maintaining the original values if not provided.
  TeamId copyWith({
    String? id,
    String? teamName,
    String? sport,
    String? gender,
    String? organization,
    String? country,
    String? zipCode,
    String? state,
    String? city,
    String? level,
    String? createdAt,
    String? updateAt,
  }) {
    return TeamId(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      sport: sport ?? this.sport,
      gender: gender ?? this.gender,
      organization: organization ?? this.organization,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      state: state ?? this.state,
      city: city ?? this.city,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// Converts the SentInvitations object to a map of key-value pairs.
  ///
  /// Returns a map representation of the SentInvitations object, where the keys
  /// are the field names and the values are the corresponding field values.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'teamName': teamName,
      'sport': sport,
      'gender': gender,
      'organization': organization,
      'country': country,
      'zipCode': zipCode,
      'state': state,
      'city': city,
      'level': level,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  /// The id of the team
  final String id;

  /// The name of the team
  final String teamName;

  /// The sport of the team
  final String sport;

  /// The gender of the team
  final String gender;

  /// The organization of the team
  final String organization;

  /// The country of the team
  final String country;

  /// The zip code of the team
  final String zipCode;

  /// The state of the team
  final String state;

  /// The city of the team
  final String city;

  /// The level of the team
  final String level;

  /// The createdAt of the team
  final String createdAt;

  /// The updateAt of the team
  final String updateAt;
}

/// Represents a user who has not registered on the app for an invitation.
class NoRegisteredUser {
  /// Constructs a [NoRegisteredUser] with required parameters.
  const NoRegisteredUser({
    required this.id,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updateAt,
    required this.teamId,
  });

  /// The factory method `NoRegisteredUser.fromMap` creates a `NoRegisteredUser` object from a map of
  /// key-value pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): The `map` parameter is a `Map` object that contains key-value pairs
  /// where the keys are `String` and the values are `dynamic`. In this context, it is used to represent
  /// the data that will be used to create a `NoRegisteredUser` object. Each key in the map
  ///
  /// Returns:
  ///   An instance of the `NoRegisteredUser` class is being returned, initialized with values extracted
  /// from the `map` parameter. The `teamId` property is being initialized with a `TeamId` object created
  /// from the map value associated with the key 'teamId'.
  factory NoRegisteredUser.fromMap(Map<String, dynamic> map) {
    return NoRegisteredUser(
      id: map['id'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
      teamId: TeamId.fromMap(map['teamId'] as Map<String, dynamic>),
    );
  }

  /// The `copyWith` function in Dart is used to create a new instance of a `NoRegisteredUser` object with
  /// updated values while maintaining the original values if not provided.
  NoRegisteredUser copyWith({
    String? id,
    String? email,
    String? phone,
    String? role,
    String? status,
    String? createdAt,
    String? updateAt,
    TeamId? teamId,
  }) {
    return NoRegisteredUser(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      teamId: teamId ?? this.teamId,
    );
  }

  /// The `toMap` function converts an object's properties into a map with string keys and dynamic values.
  ///
  /// Returns:
  ///   A `Map<String, dynamic>` is being returned. It contains key-value pairs where the keys are strings
  /// and the values are dynamic types. The keys are 'id', 'email', 'phone', 'role', 'status',
  /// 'createdAt', 'updateAt', and 'teamId'. The values associated with these keys are the corresponding
  /// properties of the object being converted to a map, such as id
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'phone': phone,
      'role': role,
      'status': status,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'teamId': teamId.toMap(),
    };
  }

  /// The id of the user
  final String id;

  /// The email of the user
  final String email;

  /// The phone number of the user
  final String phone;

  /// The role of the user
  final String role;

  /// The status of the user
  final String status;

  /// The createdAt of the user
  final String createdAt;

  /// The updateAt of the user
  final String updateAt;

  /// The teamId of the user
  final TeamId teamId;
}