/// A model class that represents a player.
class PlayerModel {
  /// Creates a new instance of the [PlayerModel] class.
  ///
  /// The [id], [firstName], [lastName], [email], [phoneNumber], [address], [role], [accountVerificationState], [fatherId], [avatar], [createdAt], and [userHasSports] parameters are required.
  PlayerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.role,
    required this.accountVerificationState,
    required this.fatherId,
    required this.avatar,
    required this.createdAt,
    required this.userHasSports,
  });

  /// Creates a new instance of the [PlayerModel] class from a map.
  ///
  /// The [map] parameter must contain the following keys:
  /// - 'id'
  /// - 'firstName'
  /// - 'lastName'
  /// - 'email'
  /// - 'phoneNumber'
  /// - 'address'
  /// - 'role'
  /// - 'accountVerificationState'
  /// - 'avatar'
  /// - 'createdAt'
  /// - 'userHasSports'
  ///
  /// The [fatherId] parameter is optional and defaults to an empty string.
  ///
  /// Throws a [FormatException] if the [map] parameter is missing any required keys.
  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      role: map['role'] as String,
      accountVerificationState: map['accountVerificationState'] as String,
      fatherId: map['fatherId'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
      createdAt: map['createdAt'] as String,
      userHasSports: List<UserHasSport>.from(
        (map['userHasSports'] as List).map<UserHasSport>(
          (x) => UserHasSport.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// The unique identifier of the player.
  final String id;

  /// The first name of the player.
  final String firstName;

  /// The last name of the player.
  final String lastName;

  /// The email address of the player.
  final String email;

  /// The phone number of the player.
  final String phoneNumber;

  /// The address of the player.
  final String address;

  /// The role of the player.
  final String role;

  /// The account verification state of the player.
  final String accountVerificationState;

  /// The unique identifier of the player's father.
  final String fatherId;

  /// The URL of the player's avatar image.
  final String avatar;

  /// The date and time the player was created.
  final String createdAt;

  /// The list of sports the player has participated in.
  final List<UserHasSport> userHasSports;

  /// Returns a new instance of [PlayerModel] with updated properties based on the provided parameters or the original values if the parameters are null.
  ///
  /// The [id], [firstName], [lastName], [email], [phoneNumber], [address], [role], [accountVerificationState], [fatherId], [avatar], [createdAt], and [userHasSports] parameters are optional.
  PlayerModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? role,
    String? accountVerificationState,
    String? fatherId,
    String? avatar,
    String? createdAt,
    List<UserHasSport>? userHasSports,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      role: role ?? this.role,
      accountVerificationState:
          accountVerificationState ?? this.accountVerificationState,
      fatherId: fatherId ?? this.fatherId,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      userHasSports: userHasSports ?? this.userHasSports,
    );
  }

  @override
  String toString() {
    return 'PlayerModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, address: $address, role: $role, accountVerificationState: $accountVerificationState, fatherId: $fatherId, avatar: $avatar, createdAt: $createdAt, userHasSports: $userHasSports)';
  }
}

/// A model class that represents a user's participation in a sport.
class UserHasSport {
  /// Creates a new instance of the [UserHasSport] class.
  ///
  /// The [id], [createdAt], [updateAt], and [sportsId] parameters are required.
  UserHasSport({
    required this.id,
    required this.createdAt,
    required this.updateAt,
    required this.sportsId,
  });

  /// Creates a new instance of the [UserHasSport] class from a map.
  ///
  /// The [map] parameter must contain the following keys:
  /// - 'id'
  /// - 'createdAt'
  /// - 'updateAt'
  /// - 'sportsId'
  ///
  /// Throws a [FormatException] if the [map] parameter is missing any required keys.
  factory UserHasSport.fromMap(Map<String, dynamic> map) {
    return UserHasSport(
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
      sportsId: SportsId.fromMap(map['sportsId'] as Map<String, dynamic>),
    );
  }

  /// Returns a new instance of [UserHasSport] with updated properties based on the provided parameters or the original values if the parameters are null.
  ///
  /// The [id], [createdAt], [updateAt], and [sportsId] parameters are optional.
  UserHasSport copyWith({
    String? id,
    String? createdAt,
    String? updateAt,
    SportsId? sportsId,
  }) {
    return UserHasSport(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      sportsId: sportsId ?? this.sportsId,
    );
  }

  /// Converts the [UserHasSport] instance to a map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'sportsId': sportsId.toMap(),
    };
  }

  @override
  String toString() {
    return 'UserHasSport(id: $id, createdAt: $createdAt, updateAt: $updateAt, sportsId: $sportsId)';
  }

  /// The unique identifier of the user's participation in a sport.
  final String id;

  /// The date and time the user's participation in a sport was created.
  final String createdAt;

  /// The date and time the user's participation in a sport was last updated.
  final String updateAt;

  /// The unique identifier of the sport the user is participating in.
  final SportsId sportsId;
}

/// A model class that represents a sport.
class SportsId {
  /// Creates a new instance of the [SportsId] class.
  ///
  /// The [id], [name], [createdAt], and [updateAt] parameters are required.
  SportsId({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updateAt,
  });

  /// Creates a new instance of the [SportsId] class from a map.
  ///
  /// The [map] parameter must contain the following keys:
  /// - 'id'
  /// - 'name'
  /// - 'createdAt'
  /// - 'updateAt'
  ///
  /// Throws a [FormatException] if the [map] parameter is missing any required keys.
  factory SportsId.fromMap(Map<String, dynamic> map) {
    return SportsId(
      id: map['id'] as String,
      name: map['name'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
    );
  }

  /// Returns a new instance of [SportsId] with updated properties based on the provided parameters or the original values if the parameters are null.
  ///
  /// The [id], [name], [createdAt], and [updateAt] parameters are optional.
  SportsId copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? updateAt,
  }) {
    return SportsId(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// Converts the [SportsId] instance to a map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  @override
  String toString() {
    return 'SportsId(id: $id, name: $name, createdAt: $createdAt, updateAt: $updateAt)';
  }

  /// The unique identifier of the sport.
  final String id;

  /// The name of the sport.
  final String name;

  /// The date and time the sport was created.
  final String createdAt;

  /// The date and time the sport was last updated.
  final String updateAt;
}
