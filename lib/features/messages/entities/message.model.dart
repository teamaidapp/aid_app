class MessageModel {
  const MessageModel({
    required this.id,
    required this.message,
    required this.isFile,
    required this.status,
    required this.createdAt,
    required this.updateAt,
    required this.userId,
    required this.fileId,
    required this.sender,
  });

  MessageModel copyWith({
    String? id,
    String? message,
    bool? isFile,
    String? status,
    String? createdAt,
    String? updateAt,
    UserId? userId,
    FileId? fileId,
    bool? sender,
  }) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      isFile: isFile ?? this.isFile,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      userId: userId ?? this.userId,
      fileId: fileId ?? this.fileId,
      sender: sender ?? this.sender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'isFile': isFile,
      'status': status,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'userId': userId.toMap(),
      'fileId': fileId?.toMap(),
      'sender': sender,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String,
      message: map['message'] as String,
      isFile: map['isFile'] as bool,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
      userId: UserId.fromMap(map['userId'] as Map<String, dynamic>),
      fileId: map['fileId'] != null ? FileId.fromMap(map['fileId'] as Map<String, dynamic>) : null,
      sender: map['sender'] as bool,
    );
  }

  final String id;
  final String message;
  final bool isFile;
  final String status;
  final String createdAt;
  final String updateAt;
  final UserId userId;
  final FileId? fileId;
  final bool sender;
}

class UserId {
  UserId({
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

  UserId copyWith({
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
    return UserId(
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

  factory UserId.fromMap(Map<String, dynamic> map) {
    return UserId(
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
      address: map['address'] as String? ?? '',
      googleAddress: map['google_address'] as String? ?? '',
      isAvatarVisible: map['isAvatarVisible'] as bool,
      biography: map['biography'] as String,
      isBiographyVisible: map['isBiographyVisible'] as bool,
      createdAt: map['createdAt'] as String,
    );
  }

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String administratorName;
  final bool isEmailVisible;
  final String phoneNumber;
  final bool isPhoneVisible;
  final String role;
  final String accountVerificationState;
  final bool isFatherVisible;
  final String avatar;
  final String position;
  final String address;
  final String googleAddress;
  final bool isAvatarVisible;
  final String biography;
  final bool isBiographyVisible;
  final String createdAt;
}

class FileId {
  final String id;
  final String description;
  final String fileName;
  final String fileKey;
  final String createdAt;
  final String updateAt;
  FileId({
    required this.id,
    required this.description,
    required this.fileName,
    required this.fileKey,
    required this.createdAt,
    required this.updateAt,
  });

  FileId copyWith({
    String? id,
    String? description,
    String? fileName,
    String? fileKey,
    String? createdAt,
    String? updateAt,
  }) {
    return FileId(
      id: id ?? this.id,
      description: description ?? this.description,
      fileName: fileName ?? this.fileName,
      fileKey: fileKey ?? this.fileKey,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'fileName': fileName,
      'fileKey': fileKey,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  factory FileId.fromMap(Map<String, dynamic> map) {
    return FileId(
      id: map['id'] as String,
      description: map['description'] as String? ?? '',
      fileName: map['fileName'] as String,
      fileKey: map['fileKey'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
    );
  }
}
