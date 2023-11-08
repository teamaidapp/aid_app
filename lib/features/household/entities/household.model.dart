// ignore_for_file: public_member_api_docs

class HouseholdModel {
  const HouseholdModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updateAt,
    required this.userId,
  });

  factory HouseholdModel.fromMap(Map<String, dynamic> map) {
    return HouseholdModel(
      id: map['id'] as String,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
      userId: UserId.fromMap(map['userId'] as Map<String, dynamic>),
    );
  }

  HouseholdModel copyWith({
    String? id,
    String? status,
    String? createdAt,
    String? updateAt,
    UserId? userId,
  }) {
    return HouseholdModel(
      id: id ?? this.id,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'userId': userId.toMap(),
    };
  }

  final String id;
  final String status;
  final String createdAt;
  final String updateAt;
  final UserId userId;
}

class UserId {
  UserId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isEmailVisible,
    required this.phoneNumber,
    required this.isPhoneVisible,
    required this.role,
    required this.accountVerificationState,
    required this.isFatherVisible,
    required this.avatar,
    required this.isAvatarVisible,
    required this.biography,
    required this.isBiographyVisible,
    required this.createdAt,
  });

  UserId copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? isEmailVisible,
    String? phoneNumber,
    bool? isPhoneVisible,
    String? role,
    String? accountVerificationState,
    bool? isFatherVisible,
    String? avatar,
    bool? isAvatarVisible,
    String? biography,
    bool? isBiographyVisible,
    String? createdAt,
  }) {
    return UserId(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      isEmailVisible: isEmailVisible ?? this.isEmailVisible,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneVisible: isPhoneVisible ?? this.isPhoneVisible,
      role: role ?? this.role,
      accountVerificationState: accountVerificationState ?? this.accountVerificationState,
      isFatherVisible: isFatherVisible ?? this.isFatherVisible,
      avatar: avatar ?? this.avatar,
      isAvatarVisible: isAvatarVisible ?? this.isAvatarVisible,
      biography: biography ?? this.biography,
      isBiographyVisible: isBiographyVisible ?? this.isBiographyVisible,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'isEmailVisible': isEmailVisible,
      'phoneNumber': phoneNumber,
      'isPhoneVisible': isPhoneVisible,
      'role': role,
      'accountVerificationState': accountVerificationState,
      'isFatherVisible': isFatherVisible,
      'avatar': avatar,
      'isAvatarVisible': isAvatarVisible,
      'biography': biography,
      'isBiographyVisible': isBiographyVisible,
      'createdAt': createdAt,
    };
  }

  factory UserId.fromMap(Map<String, dynamic> map) {
    return UserId(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String? ?? '',
      isEmailVisible: map['isEmailVisible'] as bool,
      phoneNumber: map['phoneNumber'] as String? ?? '',
      isPhoneVisible: map['isPhoneVisible'] as bool,
      role: map['role'] as String,
      isFatherVisible: map['isFatherVisible'] as bool,
      isAvatarVisible: map['isAvatarVisible'] as bool,
      isBiographyVisible: map['isBiographyVisible'] as bool,
      accountVerificationState: map['accountVerificationState'] as String? ?? '',
      biography: map['biography'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
      createdAt: map['createdAt'] as String? ?? '',
    );
  }

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isEmailVisible;
  final String phoneNumber;
  final bool isPhoneVisible;
  final String role;
  final String accountVerificationState;
  final bool isFatherVisible;
  final String avatar;
  final bool isAvatarVisible;
  final String biography;
  final bool isBiographyVisible;
  final String createdAt;
}
