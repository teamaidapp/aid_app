/// The CalendarInvitationModel class is used to represent a calendar invitation.
class CalendarInvitationModel {
  /// Constructor
  const CalendarInvitationModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updateAt,
    required this.recipientUserId,
  });

  /// The above function is a factory constructor in Dart that creates a CalendarInvitationModel object
  /// from a map of key-value pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A map containing key-value pairs where the keys are strings and the
  /// values can be of any type.
  ///
  /// Returns:
  ///   an instance of the CalendarInvitationModel class.
  factory CalendarInvitationModel.fromMap(Map<String, dynamic> map) {
    return CalendarInvitationModel(
      id: map['id'] as String,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
      recipientUserId: RecipientUserId.fromMap(map['recipient_user_id'] as Map<String, dynamic>),
    );
  }

  /// The `copyWith` function creates a new instance of `CalendarInvitationModel` with updated values for
  /// the specified properties, while keeping the existing values for the properties that are not
  /// updated.
  ///
  /// Args:
  ///   id (String): The id parameter is a String that represents the unique identifier of the calendar
  /// invitation.
  ///   status (String): The "status" parameter is used to update the status of the calendar invitation.
  /// It can have values like "pending", "accepted", "declined", etc.
  ///   createdAt (String): The `createdAt` parameter is a string that represents the date and time when
  /// the calendar invitation was created.
  ///   updateAt (String): The `updateAt` parameter is used to specify the updated date and time of the
  /// calendar invitation.
  ///   recipientUserId (RecipientUserId): The `recipientUserId` parameter is of type `RecipientUserId`,
  /// which is likely a custom data type representing the ID of the recipient user for the calendar
  /// invitation.
  ///
  /// Returns:
  ///   The method is returning a new instance of the CalendarInvitationModel class with the updated
  /// values for the specified properties.
  CalendarInvitationModel copyWith({
    String? id,
    String? status,
    String? createdAt,
    String? updateAt,
    RecipientUserId? recipientUserId,
  }) {
    return CalendarInvitationModel(
      id: id ?? this.id,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      recipientUserId: recipientUserId ?? this.recipientUserId,
    );
  }

  /// The function converts an object into a map with string keys and dynamic values.
  ///
  /// Returns:
  ///   A Map<String, dynamic> is being returned.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'recipient_user_id': recipientUserId.toMap(),
    };
  }

  /// A unique identifier for the calendar invitation.
  final String id;

  /// The current status of the calendar invitation.
  final String status;

  /// The date and time when the calendar invitation was created.
  final String createdAt;

  /// The date and time when the calendar invitation was last updated.
  final String updateAt;

  /// The recipient user of the calendar invitation.
  final RecipientUserId recipientUserId;
}

/// The RecipientUserId class is used to represent a recipient user.
class RecipientUserId {
  /// Constructor
  const RecipientUserId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.administratorName,
    required this.isEmailVisible,
    required this.phoneNumber,
    required this.isPhoneVisible,
    required this.role,
    required this.accountVerificationState,
    required this.isFatherVisible,
    required this.avatar,
    required this.position,
    required this.address,
    required this.googleAddress,
    required this.isAvatarVisible,
    required this.biography,
    required this.isBiographyVisible,
    required this.createdAt,
  });

  /// The above function is a factory constructor in Dart that takes a map as input and returns an
  /// instance of the RecipientUserId class with the values extracted from the map.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A map containing key-value pairs where the keys are strings and the
  /// values can be of any type.
  ///
  /// Returns:
  ///   The factory method is returning an instance of the class RecipientUserId.
  factory RecipientUserId.fromMap(Map<String, dynamic> map) {
    return RecipientUserId(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      administratorName: map['administratorName'] as String? ?? '',
      isEmailVisible: map['isEmailVisible'] as bool,
      phoneNumber: map['phoneNumber'] as String,
      isPhoneVisible: map['isPhoneVisible'] as bool,
      role: map['role'] as String,
      accountVerificationState: map['accountVerificationState'] as String,
      isFatherVisible: map['isFatherVisible'] as bool,
      isAvatarVisible: map['isAvatarVisible'] as bool,
      isBiographyVisible: map['isBiographyVisible'] as bool,
      createdAt: map['createdAt'] as String,
      address: map['address'] as String? ?? '',
      googleAddress: map['google_address'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
      biography: map['biography'] as String? ?? '',
      position: map['position'] as String? ?? '',
    );
  }

  /// The `copyWith` function in Dart is used to create a new instance of an object with updated values
  /// for specified properties.
  ///
  /// Args:
  ///   id (String): The unique identifier of the recipient user.
  ///   firstName (String): The first name of the recipient user.
  ///   lastName (String): The `lastName` parameter is used to specify the last name of the recipient
  /// user.
  ///   email (String): The email parameter is a String that represents the email address of the
  /// recipient user.
  ///   administratorName (String): The administrator's name for the recipient user.
  ///   isEmailVisible (bool): A boolean value indicating whether the email is visible or not.
  ///   phoneNumber (String): The `phoneNumber` parameter is used to specify the phone number of the
  /// recipient user.
  ///   isPhoneVisible (bool): A boolean value indicating whether the phone number is visible or not.
  ///   role (String): The role parameter represents the role of the recipient user. It can be used to
  /// specify the user's role within a system or organization, such as "admin", "user", "manager", etc.
  ///   accountVerificationState (String): The accountVerificationState parameter represents the
  /// verification state of the recipient's account. It can have values like "verified", "pending",
  /// "rejected", etc.
  ///   isFatherVisible (bool): A boolean value indicating whether the father's information is visible or
  /// not.
  ///   avatar (String): The avatar parameter is a string that represents the URL or file path of the
  /// recipient's avatar image.
  ///   position (String): The "position" parameter refers to the job position or title of the recipient
  /// user.
  ///   address (String): The address parameter is a string that represents the recipient's physical
  /// address.
  ///   googleAddress (String): The `googleAddress` parameter is used to specify the Google address of
  /// the recipient user.
  ///   isAvatarVisible (bool): A boolean value indicating whether the avatar is visible or not.
  ///   biography (String): A string representing the biography of the recipient user.
  ///   isBiographyVisible (bool): A boolean value indicating whether the biography of the recipient user
  /// is visible or not.
  ///   createdAt (String): The createdAt parameter is a String that represents the creation date of the
  /// recipient user.
  ///
  /// Returns:
  ///   The method is returning a new instance of the `RecipientUserId` class with the updated values for
  /// the specified properties.
  RecipientUserId copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? administratorName,
    bool? isEmailVisible,
    String? phoneNumber,
    bool? isPhoneVisible,
    String? role,
    String? accountVerificationState,
    bool? isFatherVisible,
    String? avatar,
    String? position,
    String? address,
    String? googleAddress,
    bool? isAvatarVisible,
    String? biography,
    bool? isBiographyVisible,
    String? createdAt,
  }) {
    return RecipientUserId(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      administratorName: administratorName ?? this.administratorName,
      isEmailVisible: isEmailVisible ?? this.isEmailVisible,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneVisible: isPhoneVisible ?? this.isPhoneVisible,
      role: role ?? this.role,
      accountVerificationState: accountVerificationState ?? this.accountVerificationState,
      isFatherVisible: isFatherVisible ?? this.isFatherVisible,
      avatar: avatar ?? this.avatar,
      position: position ?? this.position,
      address: address ?? this.address,
      googleAddress: googleAddress ?? this.googleAddress,
      isAvatarVisible: isAvatarVisible ?? this.isAvatarVisible,
      biography: biography ?? this.biography,
      isBiographyVisible: isBiographyVisible ?? this.isBiographyVisible,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// The function `toMap()` converts an object's properties into a map of key-value pairs.
  ///
  /// Returns:
  ///   The method is returning a Map<String, dynamic> object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'administratorName': administratorName,
      'isEmailVisible': isEmailVisible,
      'phoneNumber': phoneNumber,
      'isPhoneVisible': isPhoneVisible,
      'role': role,
      'accountVerificationState': accountVerificationState,
      'isFatherVisible': isFatherVisible,
      'avatar': avatar,
      'position': position,
      'address': address,
      'google_address': googleAddress,
      'isAvatarVisible': isAvatarVisible,
      'biography': biography,
      'isBiographyVisible': isBiographyVisible,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'Recipient_user_id(id: $id, firstName: $firstName, lastName: $lastName, email: $email, administratorName: $administratorName, isEmailVisible: $isEmailVisible, phoneNumber: $phoneNumber, isPhoneVisible: $isPhoneVisible, role: $role, accountVerificationState: $accountVerificationState, isFatherVisible: $isFatherVisible, avatar: $avatar, position: $position, address: $address, google_address: $googleAddress, isAvatarVisible: $isAvatarVisible, biography: $biography, isBiographyVisible: $isBiographyVisible, createdAt: $createdAt)';
  }

  /// A unique identifier for the recipient user.
  final String id;

  /// The first name of the recipient user.
  final String firstName;

  /// The last name of the recipient user.
  final String lastName;

  /// The email address of the recipient user.
  final String email;

  /// The name of the administrator who created the recipient user.
  final String administratorName;

  /// A flag indicating whether the recipient user's email is visible to others.
  final bool isEmailVisible;

  /// The phone number of the recipient user.
  final String phoneNumber;

  /// A flag indicating whether the recipient user's phone number is visible to others.
  final bool isPhoneVisible;

  /// The role of the recipient user.
  final String role;

  /// The account verification state of the recipient user.
  final String accountVerificationState;

  /// A flag indicating whether the recipient user's father's name is visible to others.
  final bool isFatherVisible;

  /// The avatar of the recipient user.
  final String avatar;

  /// The position of the recipient user.
  final String position;

  /// The physical address of the recipient user.
  final String address;

  /// The Google address of the recipient user.
  final String googleAddress;

  /// A flag indicating whether the recipient user's avatar is visible to others.
  final bool isAvatarVisible;

  /// The biography of the recipient user.
  final String biography;

  /// A flag indicating whether the recipient user's biography is visible to others.
  final bool isBiographyVisible;

  /// The date and time when the recipient user was created.
  final String createdAt;
}
