import 'dart:convert';

import 'package:team_aid/features/travels/entities/file.model.dart';

class TravelAPIModel {
  TravelAPIModel({
    required this.id,
    required this.isOwner,
    required this.status,
    required this.role,
    required this.createdAt,
    required this.updateAt,
    required this.itineraryId,
    required this.guest,
    required this.files,
  });

  TravelAPIModel copyWith({
    String? id,
    bool? isOwner,
    String? status,
    String? role,
    String? createdAt,
    String? updateAt,
    ItineraryId? itineraryId,
    List<GuestT>? guest,
    List<FileT>? files,
  }) {
    return TravelAPIModel(
      id: id ?? this.id,
      isOwner: isOwner ?? this.isOwner,
      status: status ?? this.status,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      itineraryId: itineraryId ?? this.itineraryId,
      guest: guest ?? this.guest,
      files: files ?? this.files,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isOwner': isOwner,
      'status': status,
      'role': role,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'itineraryId': itineraryId.toMap(),
      'guest': guest.map((x) => x.toMap()).toList(),
      'files': files.map((x) => x.toMap()).toList(),
    };
  }

  factory TravelAPIModel.fromMap(Map<String, dynamic> map) {
    return TravelAPIModel(
      id: map['id'] as String? ?? '',
      isOwner: map['isOwner'] as bool? ?? false,
      status: map['status'] as String? ?? '',
      role: map['role'] as String? ?? '',
      createdAt: map['createdAt'] as String? ?? '',
      updateAt: map['updateAt'] as String? ?? '',
      itineraryId: ItineraryId.fromMap(map['itineraryId'] as Map<String, dynamic>),
      guest: List<GuestT>.from(
        (map['guest'] as List).map<GuestT>(
          (x) => GuestT.fromMap(x as Map<String, dynamic>),
        ),
      ),
      files: List<FileT>.from(
        (map['files'] as List).map<FileT>(
          (x) => FileT.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelAPIModel.fromJson(String source) => TravelAPIModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TravelAPIModel(id: $id, isOwner: $isOwner, status: $status, role: $role, createdAt: $createdAt, updateAt: $updateAt, itineraryId: $itineraryId, guest: $guest, files: $files)';
  }

  final String id;
  final bool isOwner;
  final String status;
  final String role;
  final String createdAt;
  final String updateAt;
  final ItineraryId itineraryId;
  final List<GuestT> guest;
  final List<FileT> files;
}

class ItineraryId {
  final String id;
  final String name;
  final String transportation;
  final String startDate;
  final String endDate;
  final String arrivalDate;
  final String departureDate;
  final String location;
  final String locationDescription;
  final String hotel;
  final String hotelGoogle;
  final String createdAt;
  final String updateAt;
  final UserCreator userCreator;
  ItineraryId({
    required this.id,
    required this.name,
    required this.transportation,
    required this.startDate,
    required this.endDate,
    required this.arrivalDate,
    required this.departureDate,
    required this.location,
    required this.locationDescription,
    required this.hotel,
    required this.hotelGoogle,
    required this.createdAt,
    required this.updateAt,
    required this.userCreator,
  });

  ItineraryId copyWith({
    String? id,
    String? name,
    String? transportation,
    String? startDate,
    String? endDate,
    String? arrivalDate,
    String? departureDate,
    String? location,
    String? locationDescription,
    String? hotel,
    String? hotelGoogle,
    String? createdAt,
    String? updateAt,
    UserCreator? userCreator,
  }) {
    return ItineraryId(
      id: id ?? this.id,
      name: name ?? this.name,
      transportation: transportation ?? this.transportation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      departureDate: departureDate ?? this.departureDate,
      location: location ?? this.location,
      locationDescription: locationDescription ?? this.locationDescription,
      hotel: hotel ?? this.hotel,
      hotelGoogle: hotelGoogle ?? this.hotelGoogle,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      userCreator: userCreator ?? this.userCreator,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'transportation': transportation,
      'startDate': startDate,
      'endDate': endDate,
      'arrivalDate': arrivalDate,
      'departureDate': departureDate,
      'location': location,
      'locationDescription': locationDescription,
      'hotel': hotel,
      'hotelGoogle': hotelGoogle,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'userCreator': userCreator.toMap(),
    };
  }

  factory ItineraryId.fromMap(Map<String, dynamic> map) {
    return ItineraryId(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      transportation: map['transportation'] as String? ?? '',
      startDate: map['startDate'] as String? ?? '',
      endDate: map['endDate'] as String? ?? '',
      arrivalDate: map['arrivalDate'] as String? ?? '',
      departureDate: map['departureDate'] as String? ?? '',
      location: map['location'] as String? ?? '',
      locationDescription: map['locationDescription'] as String? ?? '',
      hotel: map['hotel'] as String? ?? '',
      hotelGoogle: map['hotelGoogle'] as String? ?? '',
      createdAt: map['createdAt'] as String? ?? '',
      updateAt: map['updateAt'] as String? ?? '',
      userCreator: UserCreator.fromMap(map['userCreator'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItineraryId.fromJson(String source) => ItineraryId.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItineraryId(id: $id, name: $name, transportation: $transportation, startDate: $startDate, endDate: $endDate, arrivalDate: $arrivalDate, departureDate: $departureDate, location: $location, locationDescription: $locationDescription, hotel: $hotel, hotelGoogle: $hotelGoogle, createdAt: $createdAt, updateAt: $updateAt, userCreator: $userCreator)';
  }

  @override
  bool operator ==(covariant ItineraryId other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.transportation == transportation &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.arrivalDate == arrivalDate &&
        other.departureDate == departureDate &&
        other.location == location &&
        other.locationDescription == locationDescription &&
        other.hotel == hotel &&
        other.hotelGoogle == hotelGoogle &&
        other.createdAt == createdAt &&
        other.updateAt == updateAt &&
        other.userCreator == userCreator;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        transportation.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        arrivalDate.hashCode ^
        departureDate.hashCode ^
        location.hashCode ^
        locationDescription.hashCode ^
        hotel.hashCode ^
        hotelGoogle.hashCode ^
        createdAt.hashCode ^
        updateAt.hashCode ^
        userCreator.hashCode;
  }
}

class UserCreator {
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
  final String google_address;
  final bool isAvatarVisible;
  final String biography;
  final bool isBiographyVisible;
  final String createdAt;
  UserCreator({
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
    required this.google_address,
    required this.isAvatarVisible,
    required this.biography,
    required this.isBiographyVisible,
    required this.createdAt,
  });

  UserCreator copyWith({
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
    String? google_address,
    bool? isAvatarVisible,
    String? biography,
    bool? isBiographyVisible,
    String? createdAt,
  }) {
    return UserCreator(
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
      google_address: google_address ?? this.google_address,
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
      'google_address': google_address,
      'isAvatarVisible': isAvatarVisible,
      'biography': biography,
      'isBiographyVisible': isBiographyVisible,
      'createdAt': createdAt,
    };
  }

  factory UserCreator.fromMap(Map<String, dynamic> map) {
    return UserCreator(
      id: map['id'] as String? ?? '',
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      administratorName: map['administratorName'] as String? ?? '',
      isEmailVisible: map['isEmailVisible'] as bool? ?? false,
      phoneNumber: map['phoneNumber'] as String? ?? '',
      isPhoneVisible: map['isPhoneVisible'] as bool? ?? false,
      role: map['role'] as String? ?? '',
      accountVerificationState: map['accountVerificationState'] as String? ?? '',
      isFatherVisible: map['isFatherVisible'] as bool? ?? false,
      avatar: map['avatar'] as String? ?? '',
      position: map['position'] as String? ?? '',
      address: map['address'] as String? ?? '',
      google_address: map['google_address'] as String? ?? '',
      isAvatarVisible: map['isAvatarVisible'] as bool? ?? false,
      biography: map['biography'] as String? ?? '',
      isBiographyVisible: map['isBiographyVisible'] as bool? ?? false,
      createdAt: map['createdAt'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCreator.fromJson(String source) => UserCreator.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserCreator(id: $id, firstName: $firstName, lastName: $lastName, email: $email, administratorName: $administratorName, isEmailVisible: $isEmailVisible, phoneNumber: $phoneNumber, isPhoneVisible: $isPhoneVisible, role: $role, accountVerificationState: $accountVerificationState, isFatherVisible: $isFatherVisible, avatar: $avatar, position: $position, address: $address, google_address: $google_address, isAvatarVisible: $isAvatarVisible, biography: $biography, isBiographyVisible: $isBiographyVisible, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserCreator other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.administratorName == administratorName &&
        other.isEmailVisible == isEmailVisible &&
        other.phoneNumber == phoneNumber &&
        other.isPhoneVisible == isPhoneVisible &&
        other.role == role &&
        other.accountVerificationState == accountVerificationState &&
        other.isFatherVisible == isFatherVisible &&
        other.avatar == avatar &&
        other.position == position &&
        other.address == address &&
        other.google_address == google_address &&
        other.isAvatarVisible == isAvatarVisible &&
        other.biography == biography &&
        other.isBiographyVisible == isBiographyVisible &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        administratorName.hashCode ^
        isEmailVisible.hashCode ^
        phoneNumber.hashCode ^
        isPhoneVisible.hashCode ^
        role.hashCode ^
        accountVerificationState.hashCode ^
        isFatherVisible.hashCode ^
        avatar.hashCode ^
        position.hashCode ^
        address.hashCode ^
        google_address.hashCode ^
        isAvatarVisible.hashCode ^
        biography.hashCode ^
        isBiographyVisible.hashCode ^
        createdAt.hashCode;
  }
}

class GuestT {
  final String id;
  final String status;
  final UserId userId;
  GuestT({
    required this.id,
    required this.status,
    required this.userId,
  });

  GuestT copyWith({
    String? id,
    String? status,
    UserId? userId,
  }) {
    return GuestT(
      id: id ?? this.id,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'userId': userId.toMap(),
    };
  }

  factory GuestT.fromMap(Map<String, dynamic> map) {
    return GuestT(
      id: map['id'] as String? ?? '',
      status: map['status'] as String? ?? '',
      userId: UserId.fromMap(map['userId'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GuestT.fromJson(String source) => GuestT.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Guest(id: $id, status: $status, userId: $userId)';

  @override
  bool operator ==(covariant GuestT other) {
    if (identical(this, other)) return true;

    return other.id == id && other.status == status && other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ userId.hashCode;
}

class UserId {
  final String id;
  final String firstName;
  final String lastName;
  final String avatar;
  UserId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  UserId copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? avatar,
  }) {
    return UserId(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };
  }

  factory UserId.fromMap(Map<String, dynamic> map) {
    return UserId(
      id: map['id'] as String? ?? '',
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'UserId(id: $id, firstName: $firstName, lastName: $lastName, avatar: $avatar)';
  }
}
