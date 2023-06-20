// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:team_aid/core/enums/role.enum.dart';

/// The UserModel class is a data model that represents a user in the system.
class UserModel {
  /// Constructor
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.sportId,
    required this.role,
    required this.cityId,
    required this.stateId,
  });

  /// This is a factory function in Dart that creates a UserModel object from a map of key-value pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A Map object that contains key-value pairs representing the
  /// properties of a user.
  ///
  /// Returns:
  ///   A `UserModel` object is being returned. The `fromMap` method takes a `Map` of key-value pairs as
  /// input and uses it to create and return a new instance of `UserModel`.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      sportId: map['sportId'] as String,
      role: map['role'] as String == 'coach'
          ? Role.coach
          : map['role'] as String == 'client'
              ? Role.client
              : Role.support,
      cityId: map['cityId'] as String,
      stateId: map['stateId'] as String,
    );
  }

  /// The function returns a new instance of UserModel with updated properties based on the provided
  /// parameters or the existing values if the parameters are null.
  ///
  /// Args:
  ///   firstName (String): A string representing the first name of a user.
  ///   lastName (String): The `lastName` parameter is a `String` type and represents the last name of a
  /// user in a `UserModel` object. It is an optional parameter that can be passed to the `copyWith`
  /// method to create a new `UserModel` object with the same properties as the original object
  ///   email (String): The email parameter is a String that represents the email address of a user in a
  /// UserModel object. It can be updated using the copyWith method.
  ///   phoneNumber (String): The `phoneNumber` parameter is a `String` that represents the phone number
  /// of a user in the `UserModel` class. It can be updated using the `copyWith` method. If the
  /// `phoneNumber` parameter is not provided, the method returns a new `UserModel` object with the
  ///   address (String): The address of the user.
  ///   password (String): The password parameter is a string that represents the user's password. It is
  /// an optional parameter that can be used to update the password of an existing user in the UserModel
  /// class. If the parameter is not provided, the existing password value will be used.
  ///   role (Role): The "role" parameter is of type "Role", which is likely an enum that represents the
  /// user's role or permission level in the system. It could be used to determine what actions the user
  /// is allowed to perform or what information they have access to.
  ///
  /// Returns:
  ///   The `copyWith` method is returning a new instance of the `UserModel` class with updated values
  /// for the properties passed as parameters. If a parameter is not passed or is null, the original
  /// value of that property is used.
  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? password,
    String? sportId,
    Role? role,
    String? cityId,
    String? stateId,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      password: password ?? this.password,
      sportId: sportId ?? this.sportId,
      role: role ?? this.role,
      cityId: cityId ?? this.cityId,
      stateId: stateId ?? this.stateId,
    );
  }

  /// This function converts an object's properties into a map with string keys and dynamic values.
  ///
  /// Returns:
  ///   A `Map` object with keys as `String` and values as `dynamic` data type. The keys are 'firstName',
  /// 'lastName', 'email', 'phoneNumber', 'address', 'password', and 'role'. The values are the
  /// corresponding values of the instance variables `firstName`, `lastName`, `email`, `phoneNumber`,
  /// `address`, `password`, and `role`.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'password': password,
      'sportId': sportId,
      'cityId': cityId,
      'stateId': stateId,
      'role': role.name,
    };
  }

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, address: $address, password: $password, role: $role)';
  }

  /// The user's first name.
  final String firstName;

  /// The user's last name.
  final String lastName;

  /// The user's email address.
  final String email;

  /// The user's phone number.
  final String phoneNumber;

  /// The user's address.
  final String address;

  /// The user's password.
  final String password;

  /// The user's sport id.
  final String sportId;

  /// The user's role in the system.
  final Role role;

  /// The user's city id.
  final String cityId;

  /// The user's state id.
  final String stateId;

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
