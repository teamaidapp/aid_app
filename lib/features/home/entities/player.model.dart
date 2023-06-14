/// A model class that represents a player.
class PlayerModel {
  /// Constructor
  const PlayerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.role,
    required this.acceptTermsAndConditions,
    required this.otpExpiration,
    required this.otpCode,
    required this.accountVerificationState,
    required this.fatherId,
    required this.avatar,
    required this.createdAt,
    required this.updateAt,
  });

  /// This is a factory function in Dart that creates a PlayerModel object from a map of key-value pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A Map object that contains key-value pairs representing the
  /// properties of a PlayerModel object.
  ///
  /// Returns:
  ///   A PlayerModel object is being returnedj. The object is created using the values obtained from the
  /// map parameter passed to the factory method.
  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
      acceptTermsAndConditions: map['acceptTermsAndConditions'] as bool,
      otpExpiration: map['otpExpiration'] as String,
      otpCode: map['otpCode'] as String,
      accountVerificationState: map['accountVerificationState'] as String,
      fatherId: map['fatherId'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
    );
  }

  /// This is a copyWith function in Dart that returns a new instance of a PlayerModel with updated
  /// properties.
  ///
  /// Args:
  ///   id (String): The unique identifier of the player.
  ///   firstName (String): The first name of the player.
  ///   lastName (String): A string representing the last name of the player.
  ///   email (String): A string representing the email address of the player.
  ///   phoneNumber (String): A string representing the phone number of the player.
  ///   address (String): A string representing the player's address.
  ///   password (String): The password of the player account.
  ///   role (String): The role of the player, which could be "admin", "player", or any other role
  /// defined by the system.
  ///   acceptTermsAndConditions (bool): A boolean value indicating whether the player has accepted the
  /// terms and conditions of the platform.
  ///   accountVerificationState (String): A string representing the current state of the player's
  /// account verification process. This could be "pending", "approved", "rejected", or any other state
  /// defined by the application.
  ///   otpExpiration (String): A string representing the expiration time of the OTP (One-Time Password)
  /// code for the player's account verification.
  ///   otpCode (String): The otpCode parameter is a string that represents the one-time password code
  /// used for two-factor authentication. It can be passed as an argument to the copyWith method to
  /// create a new instance of the PlayerModel class with the same values as the original instance,
  /// except for the otpCode parameter which can be
  ///   fatherId (String): The ID of the player's father or parent account, if applicable.
  ///   avatar (String): A string representing the URL or file path of the player's avatar image.
  ///   createdAt (String): A string representing the date and time when the player's account was
  /// created.
  ///   updateAt (String): A string representing the timestamp of when the player's information was last
  /// updated.
  ///
  /// Returns:
  ///   The method is returning a new instance of the PlayerModel class with updated values for the
  /// properties passed as parameters. If a parameter is not passed or is null, the method uses the
  /// current value of the property in the original instance.
  PlayerModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? password,
    String? role,
    bool? acceptTermsAndConditions,
    String? accountVerificationState,
    String? otpExpiration,
    String? otpCode,
    String? fatherId,
    String? avatar,
    String? createdAt,
    String? updateAt,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      password: password ?? this.password,
      role: role ?? this.role,
      acceptTermsAndConditions:
          acceptTermsAndConditions ?? this.acceptTermsAndConditions,
      otpExpiration: otpExpiration ?? this.otpExpiration,
      otpCode: otpCode ?? this.otpCode,
      accountVerificationState:
          accountVerificationState ?? this.accountVerificationState,
      fatherId: fatherId ?? this.fatherId,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// The function returns a map of key-value pairs representing the properties of an object.
  ///
  /// Returns:
  ///   A Map object with keys as String and values as dynamic data type. The keys represent the
  /// properties of an object and the values represent their corresponding values.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'password': password,
      'role': role,
      'acceptTermsAndConditions': acceptTermsAndConditions,
      'otpExpiration': otpExpiration,
      'otpCode': otpCode,
      'accountVerificationState': accountVerificationState,
      'fatherId': fatherId,
      'avatar': avatar,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  @override
  String toString() {
    return 'PlayerModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, address: $address, password: $password, role: $role, acceptTermsAndConditions: $acceptTermsAndConditions, otpExpiration: $otpExpiration, otpCode: $otpCode, accountVerificationState: $accountVerificationState, fatherId: $fatherId, avatar: $avatar, createdAt: $createdAt, updateAt: $updateAt)';
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

  /// The password of the player.
  final String password;

  /// The role of the player.
  final String role;

  /// Whether the player has accepted the terms and conditions.
  final bool acceptTermsAndConditions;

  /// The expiration date of the one-time password (OTP) for the player.
  final String? otpExpiration;

  /// The one-time password (OTP) for the player.
  final String? otpCode;

  /// The account verification state of the player.
  final String accountVerificationState;

  /// The unique identifier of the player's father.
  final String? fatherId;

  /// The URL of the player's avatar.
  final String? avatar;

  /// The date and time when the player was created.
  final String createdAt;

  /// The date and time when the player was last updated.
  final String updateAt;
}
