/// A class representing a guest for an itinerary.
class UserCreator {
  /// Creates a new instance of [UserCreator].
  const UserCreator({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.role,
    required this.acceptTermsAndConditions,
    required this.accountVerificationState,
    required this.avatar,
    required this.biography,
    required this.createdAt,
    required this.updateAt,
    this.otpExpiration,
    this.fatherId,
    this.otpCode,
  });

  /// Creates a new instance of [UserCreator] from a map.
  factory UserCreator.fromMap(Map<String, dynamic> map) {
    return UserCreator(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
      acceptTermsAndConditions: map['acceptTermsAndConditions'] as bool,
      otpExpiration: map['otpExpiration'] != null ? map['otpExpiration'] as String : null,
      otpCode: map['otpCode'] != null ? map['otpCode'] as String : null,
      accountVerificationState: map['accountVerificationState'] as String,
      fatherId: map['fatherId'] != null ? map['fatherId'] as String : null,
      avatar: map['avatar'] as String,
      biography: map['biography'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
    );
  }

  /// The id of the user.
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
      'biography': biography,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  /// The ID of the itinerary.
  final String id;

  /// The first name of the itinerary.
  final String firstName;

  /// The last name of the itinerary.
  final String lastName;

  /// The email of the itinerary.
  final String email;

  /// The phone number of the itinerary.
  final String phoneNumber;

  /// The address of the itinerary.
  final String address;

  /// The password of the itinerary.
  final String password;

  /// The role of the itinerary.
  final String role;

  /// The acceptance of terms and conditions of the itinerary.
  final bool acceptTermsAndConditions;

  /// The OTP expiration date of the itinerary.
  final String? otpExpiration;

  /// The OTP code of the itinerary.
  final String? otpCode;

  /// The account verification state of the itinerary.
  final String accountVerificationState;

  /// The ID of the itinerary's father.
  final String? fatherId;

  /// The avatar of the itinerary.
  final String avatar;

  /// The biography of the itinerary.
  final String biography;

  /// The creation date of the itinerary.
  final String createdAt;

  /// The update date of the itinerary.
  final String updateAt;
}
