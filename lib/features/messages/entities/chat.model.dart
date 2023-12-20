/// Represents a chat model.
class ChatModel {
  /// Creates a new chat model.
  ///
  /// Requires an [id], [createdAt] timestamp, [userChatCreator], [userChatReceiver], and [team].
  const ChatModel({
    required this.id,
    required this.createdAt,
    required this.userChatCreator,
    required this.userChatReceiver,
    required this.team,
    required this.sender,
    required this.lastMessage,
  });

  /// Creates a new chat model from a map.
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      userChatCreator: UserChatCreator.fromMap(map['userChatCreator'] as Map<String, dynamic>),
      userChatReceiver: UserChatReceiver.fromMap(map['userChatReceiver'] as Map<String, dynamic>),
      team: Team.fromMap(map['team'] as Map<String, dynamic>),
      sender: map['sender'] as bool,
      lastMessage: LastMessage.fromMap(map['lastMessage'] as Map<String, dynamic>),
    );
  }

  /// Creates a copy of this chat model but with the given fields replaced with the new values.
  ChatModel copyWith({
    String? id,
    String? createdAt,
    UserChatCreator? userChatCreator,
    UserChatReceiver? userChatReceiver,
    Team? team,
    bool? sender,
    LastMessage? lastMessage,
  }) {
    return ChatModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userChatCreator: userChatCreator ?? this.userChatCreator,
      userChatReceiver: userChatReceiver ?? this.userChatReceiver,
      team: team ?? this.team,
      sender: sender ?? this.sender,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  /// Converts this chat model into a map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'userChatCreator': userChatCreator.toMap(),
      'userChatReceiver': userChatReceiver.toMap(),
      'team': team.toMap(),
    };
  }

  /// A unique identifier for the chat model.
  final String id;

  /// The date and time when the chat model was created.
  final String createdAt;

  /// The user who created the chat.
  final UserChatCreator userChatCreator;

  /// The user who received the chat.
  final UserChatReceiver userChatReceiver;

  /// The team associated with the chat.
  final Team team;

  /// The last message of the chat.
  final bool sender;

  /// The last message of the chat.
  final LastMessage lastMessage;
}

/// Represents a user chat creator.
class UserChatCreator {
  /// Creates a new instance of [UserChatCreator].
  const UserChatCreator({
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

  /// Creates a [UserChatCreator] from a map.
  factory UserChatCreator.fromMap(Map<String, dynamic> map) {
    return UserChatCreator(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      isEmailVisible: map['isEmailVisible'] as bool,
      phoneNumber: map['phoneNumber'] as String,
      isPhoneVisible: map['isPhoneVisible'] as bool,
      role: map['role'] as String,
      accountVerificationState: map['accountVerificationState'] as String,
      isFatherVisible: map['isFatherVisible'] as bool,
      administratorName: map['administratorName'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
      position: map['position'] as String? ?? '',
      address: map['address'] as String,
      googleAddress: map['google_address'] as String,
      isAvatarVisible: map['isAvatarVisible'] as bool,
      biography: map['biography'] as String,
      isBiographyVisible: map['isBiographyVisible'] as bool,
      createdAt: map['createdAt'] as String,
    );
  }

  /// Creates a copy of [UserChatCreator] with the specified properties overridden.
  UserChatCreator copyWith({
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
    return UserChatCreator(
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

  /// Converts [UserChatCreator] to a map.
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

  /// The unique identifier of the chat.
  final String id;

  /// The first name of the chat user.
  final String firstName;

  /// The last name of the chat user.
  final String lastName;

  /// The email of the chat user.
  final String email;

  /// The name of the chat administrator.
  final String administratorName;

  /// Indicates whether the email is visible or not.
  final bool isEmailVisible;

  /// The phone number of the chat user.
  final String phoneNumber;

  /// Indicates whether the phone number is visible or not.
  final bool isPhoneVisible;

  /// The role of the chat user.
  final String role;

  /// The account verification state of the chat user.
  final String accountVerificationState;

  /// Indicates whether the father is visible or not.
  final bool isFatherVisible;

  /// The avatar of the chat user.
  final String avatar;

  /// The position of the chat user.
  final String position;

  /// The address of the chat user.
  final String address;

  /// The Google address of the chat user.
  final String googleAddress;

  /// Indicates whether the avatar is visible or not.
  final bool isAvatarVisible;

  /// The biography of the chat user.
  final String biography;

  /// Indicates whether the biography is visible or not.
  final bool isBiographyVisible;

  /// The creation date of the chat.
  final String createdAt;
}

/// Represents a user chat receiver.
class UserChatReceiver {
  /// Constructs a [UserChatReceiver].
  const UserChatReceiver({
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

  /// Creates a [UserChatReceiver] from a map.
  factory UserChatReceiver.fromMap(Map<String, dynamic> map) {
    return UserChatReceiver(
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
      avatar: map['avatar'] as String? ?? '',
      position: map['position'] as String? ?? '',
      address: map['address'] as String? ?? '',
      googleAddress: map['google_address'] as String? ?? '',
      isAvatarVisible: map['isAvatarVisible'] as bool,
      biography: map['biography'] as String,
      isBiographyVisible: map['isBiographyVisible'] as bool,
      createdAt: map['createdAt'] as String,
    );
  }

  /// Creates a copy of the [UserChatReceiver] with the specified fields replaced with new values.
  UserChatReceiver copyWith({
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
    return UserChatReceiver(
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

  /// Converts the [UserChatReceiver] to a map.
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

  /// Unique identifier for each instance of the class
  final String id;

  /// First name of the user
  final String firstName;

  /// Last name of the user
  final String lastName;

  /// Email address of the user
  final String email;

  /// Name of the administrator associated with the user
  final String administratorName;

  /// Boolean indicating whether the user's email is visible to others
  final bool isEmailVisible;

  /// Phone number of the user
  final String phoneNumber;

  /// Boolean indicating whether the user's phone number is visible to others
  final bool isPhoneVisible;

  /// Role of the user (e.g., admin, user, guest)
  final String role;

  /// Verification state of the user's account
  final String accountVerificationState;

  /// Boolean indicating whether the user's father is visible to others
  final bool isFatherVisible;

  /// Avatar of the user
  final String avatar;

  /// Position of the user
  final String position;

  /// Physical address of the user
  final String address;

  /// Google address of the user
  final String googleAddress;

  /// Boolean indicating whether the user's avatar is visible to others
  final bool isAvatarVisible;

  /// Short biography of the user
  final String biography;

  /// Boolean indicating whether the user's biography is visible to others
  final bool isBiographyVisible;

  /// Timestamp of when the user was created
  final String createdAt;
}

/// Represents a team.
class Team {
  /// Creates a new instance of Team
  const Team({
    required this.id, // Unique identifier for the team
    required this.teamName, // Name of the team
    required this.sport, // Sport that the team plays
    required this.gender, // Gender of the team members
    required this.organization, // Organization that the team belongs to
    required this.country, // Country where the team is located
    required this.zipCode, // Zip code of the team's location
    required this.state, // State where the team is located
    required this.city, // City where the team is located
    required this.level, // Level of the team (e.g., amateur, professional)
    required this.createdAt, // Timestamp of when the team was created
    required this.updateAt, // Timestamp of the last update to the team's information
  });

  /// Creates a new instance of Team from a map
  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
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

  /// Creates a copy of this Team but with the given fields replaced with the new values.
  Team copyWith({
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
    return Team(
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

  /// Converts this Team instance to a Map
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

  /// Unique identifier for the team
  final String id;

  /// Name of the team
  final String teamName;

  /// Sport that the team plays
  final String sport;

  /// Gender of the team members
  final String gender;

  /// Organization that the team belongs to
  final String organization;

  /// Country where the team is located
  final String country;

  /// Zip code of the team's location
  final String zipCode;

  /// State where the team is located
  final String state;

  /// City where the team is located
  final String city;

  /// Level of the team
  final String level;

  /// Timestamp of when the team was created
  final String createdAt;

  /// Timestamp of the last update to the team's information
  final String updateAt;
}

/// Represents a last message.
class LastMessage {
  /// Constructor
  const LastMessage({
    required this.id,
    required this.message,
    required this.isFile,
    required this.status,
    required this.createdAt,
    required this.updateAt,
  });

  /// The above function is a factory constructor in Dart that creates a LastMessage object from a map
  /// of key-value pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A map containing key-value pairs where the keys are strings and the
  /// values can be of any type.
  ///
  /// Returns:
  ///   The factory method is returning an instance of the LastMessage class.
  factory LastMessage.fromMap(Map<String, dynamic> map) {
    return LastMessage(
      id: map['id'] as String,
      message: map['message'] as String,
      isFile: map['isFile'] as bool,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
    );
  }

  /// The `copyWith` function in Dart is used to create a new instance of an object with updated values
  /// for specified properties.
  ///
  /// Args:
  ///   id (String): The unique identifier of the last message.
  ///   message (String): The `message` parameter is a string that represents the content of the message.
  ///   isFile (bool): A boolean value indicating whether the message is a file or not.
  ///   status (String): The "status" parameter is used to indicate the status of the message. It can be
  /// used to track whether the message has been sent, delivered, read, or any other status that you
  /// define in your application.
  ///   createdAt (String): The `createdAt` parameter is a string representing the date and time when the
  /// message was created.
  ///   updateAt (String): The `updateAt` parameter is used to specify the updated timestamp of the last
  /// message. It represents the time when the last message was last updated.
  ///
  /// Returns:
  ///   The method is returning a new instance of the `LastMessage` class with updated values for the
  /// provided parameters.
  LastMessage copyWith({
    String? id,
    String? message,
    bool? isFile,
    String? status,
    String? createdAt,
    String? updateAt,
  }) {
    return LastMessage(
      id: id ?? this.id,
      message: message ?? this.message,
      isFile: isFile ?? this.isFile,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// The function `toMap()` converts an object's properties into a map with string keys and dynamic
  /// values.
  ///
  /// Returns:
  ///   A Map<String, dynamic> is being returned.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'isFile': isFile,
      'status': status,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  /// Unique identifier for the last message
  final String id;

  /// Message of the last message
  final String message;

  /// Boolean indicating whether the last message is a file or not
  final bool isFile;

  /// Status of the last message
  final String status;

  /// Timestamp of when the last message was created
  final String createdAt;

  /// Timestamp of the last update to the last message
  final String updateAt;
}
