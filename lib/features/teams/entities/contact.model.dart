/// A model class that represents a contact.
class ContactModel {
  /// Creates a new instance of the [ContactModel] class.
  ///
  /// The [id], [status], and [user] parameters are required.
  ContactModel({
    required this.id,
    required this.status,
    required this.user,
  });

  /// Creates a new instance of the [ContactModel] class from a map.
  ///
  /// The [map] parameter must contain the following keys:
  /// - 'id'
  /// - 'status'
  /// - 'user'
  ///
  /// Throws a [FormatException] if the [map] parameter is missing any required keys.
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] as String,
      status: map['status'] as String,
      user: UserContactModel.fromMap(map['userId'] as Map<String, dynamic>),
    );
  }

  /// Creates a new instance of the [ContactModel] class with the same values as this instance.
  ///
  /// The [id], [status], and [user] parameters can be optionally provided to create a copy with different values.
  ContactModel copyWith({
    String? id,
    String? status,
    UserContactModel? user,
  }) {
    return ContactModel(
      id: id ?? this.id,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  /// The unique identifier of the contact.
  final String id;

  /// The status of the contact.
  final String status;

  /// The user associated with the contact.
  final UserContactModel user;
}

/// A model class that represents a user contact.
class UserContactModel {
  /// Constructor
  UserContactModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
    required this.avatar,
  });

  /// This is a factory function in Dart that creates a UserContactModel object from a map of key-value pairs.
  factory UserContactModel.fromMap(Map<String, dynamic> map) {
    return UserContactModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      role: map['role'] as String,
      avatar: map['avatar'] as String? ?? '',
    );
  }

  /// The unique identifier of the contact.
  final String id;

  /// The first name of the contact.
  final String firstName;

  /// The last name of the contact.
  final String lastName;

  /// The phone number of the contact.
  final String phoneNumber;

  /// The role of the contact.
  final String role;

  /// The avatar of the contact.
  final String avatar;
}
