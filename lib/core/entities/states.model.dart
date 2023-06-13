/// The StatesModel class represents a state with various properties and methods for creating, updating,
/// and converting the state object.
class StateModel {
  /// Constructor
  StateModel({
    required this.id,
    required this.name,
    required this.stateCode,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
    required this.countryName,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  /// This is a factory function in Dart that creates a StatesModel object from a map of key-value pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A Map object containing key-value pairs where the keys are strings and
  /// the values can be of any type.
  ///
  /// Returns:
  ///   A `StatesModel` object is being returned.
  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      id: map['id'] as String,
      name: map['name'] as String,
      stateCode: map['stateCode'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      countryCode: map['countryCode'] as String,
      countryName: map['countryName'] as String,
      type: map['type'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  /// The function returns a new instance of StatesModel with updated properties based on the provided
  /// parameters or the original values if the parameters are null.
  ///
  /// Args:
  ///   id (String): The unique identifier of the state.
  ///   name (String): The name of the state.
  ///   stateCode (String): The state code of a particular state in a country. It is usually a two-letter
  /// code that uniquely identifies the state within the country.
  ///   latitude (String): Latitude is a geographic coordinate that specifies the north-south position of
  /// a point on the Earth's surface. It is measured in degrees, minutes, and seconds of arc north or
  /// south of the equator.
  ///   longitude (String): Longitude is a geographic coordinate that specifies the east-west position of
  /// a point on the Earth's surface. It is measured in degrees, minutes, and seconds, with values ranging
  /// from 0 to 180 degrees east or west of the Prime Meridian. Longitude is often used in conjunction
  /// with latitude to pinpoint
  ///   countryCode (String): The parameter "countryCode" is a String that represents the code of the
  /// country to which the state belongs.
  ///   countryName (String): The name of the country to which the state belongs.
  ///   type (String): The "type" parameter is a string that represents the type of the state. It could be
  /// something like "province", "territory", "region", etc.
  ///   createdAt (String): A string representing the date and time when the state was created.
  ///   updatedAt (String): The `updatedAt` parameter is a string that represents the date and time when
  /// the state was last updated. It is an optional parameter that can be passed to the `copyWith` method
  /// of the `StatesModel` class to create a new instance of the class with updated values. If the
  /// `updatedAt
  ///
  /// Returns:
  ///   The `copyWith` method is returning a new instance of the `StatesModel` class with updated values
  /// for the properties passed as parameters. If a parameter is not passed or is null, the method uses
  /// the current value of the property.
  StateModel copyWith({
    String? id,
    String? name,
    String? stateCode,
    String? latitude,
    String? longitude,
    String? countryCode,
    String? countryName,
    String? type,
    String? createdAt,
    String? updatedAt,
  }) {
    return StateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      stateCode: stateCode ?? this.stateCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// This function converts an object's properties into a map of key-value pairs.
  ///
  /// Returns:
  ///   A `Map` object with keys as `String` and values as `dynamic` data type. The keys are `id`, `name`,
  /// `stateCode`, `latitude`, `longitude`, `countryCode`, `countryName`, `type`, `created_at`, and
  /// `updated_at`. The values are the corresponding values of the instance variables of the class.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'stateCode': stateCode,
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
      'countryName': countryName,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  ///this method will prevent the override of toString
  @override
  String toString() {
    return name;
  }

  /// The unique identifier of the state.
  final String id;

  /// The name of the state.
  final String name;

  /// The code of the state.
  final String stateCode;

  /// The latitude of the state.
  final String latitude;

  /// The longitude of the state.
  final String longitude;

  /// The code of the country the state belongs to.
  final String countryCode;

  /// The name of the country the state belongs to.
  final String countryName;

  /// The type of the state.
  final String type;

  /// The date and time the state was created.
  final String createdAt;

  /// The date and time the state was last updated.
  final String updatedAt;
}
