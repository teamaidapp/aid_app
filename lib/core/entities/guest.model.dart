/// The guest model
class Guest {
  /// This is the constructor of the Guest class.
  const Guest({
    required this.userId,
  });

  /// This is a factory constructor in Dart that creates a Guest object from a map of key-value pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A Map object that contains key-value pairs representing the
  /// properties of a Guest object.
  ///
  /// Returns:
  ///   A `Guest` object is being returned. The `Guest` object is created using the `fromMap` factory
  /// constructor, which takes a `Map` as input and returns a `Guest` object. The `Map` contains a
  /// key-value pair where the key is a `String` and the value is a `dynamic` type. The `userId` property
  /// of the `Guest` object is
  factory Guest.fromMap(Map<String, dynamic> map) {
    return Guest(
      userId: (map['userId'] as Map<String, dynamic>?)?['id'] as String? ?? '',
    );
  }

  /// This function returns a map with a key-value pair of userId and its corresponding value.
  ///
  /// Returns:
  ///   A `Map` object with a `String` key `'userId'` and a value of the `userId` property of the object.
  /// The value is of type `dynamic`, which means it can be any data type.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
    };
  }

  /// The user id
  final String userId;
}
