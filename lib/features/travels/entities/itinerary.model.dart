import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/entities/user_creator.model.dart';

/// A class representing an itinerary for an event.
class ItineraryModel {
  /// Creates a new instance of [ItineraryModel].
  ///
  /// The [name] parameter is required and represents the name of the itinerary.
  ///
  /// The [transportation] parameter is required and represents the transportation for the itinerary.
  ///
  /// The [startDate] parameter is required and represents the start date of the itinerary.
  ///
  /// The [endDate] parameter is required and represents the end date of the itinerary.
  ///
  /// The [location] parameter is required and represents the location of the itinerary.
  ///
  /// The [guests] parameter is required and represents the list of guests for the itinerary.
  ///
  /// The [userCreator] parameter is required and represents the user creator of the itinerary.
  const ItineraryModel({
    required this.name,
    required this.transportation,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.locationDescription,
    required this.guests,
    this.userCreator,
    this.fileId,
  });

  /// Creates a new instance of [ItineraryModel] from a map.
  ///
  /// The [map] parameter is required and represents the map to convert to an [ItineraryModel] instance.
  factory ItineraryModel.fromMap(Map<String, dynamic> map, List<dynamic> guest) {
    return ItineraryModel(
      name: map['name'] as String,
      transportation: map['transportation'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      location: map['location'] as String,
      locationDescription: map['locationDescription'] as String,
      userCreator: UserCreator.fromMap(map['userCreator'] as Map<String, dynamic>),
      guests: guest.map((x) => Guest.fromMap(x as Map<String, dynamic>)).toList(),
      fileId: map['fileId'] as String? ?? '',
    );
  }

  /// The name of the itinerary.
  final String name;

  /// The transportation for the itinerary.
  final String transportation;

  /// The start date of the itinerary.
  final String startDate;

  /// The end date of the itinerary.
  final String endDate;

  /// The location of the itinerary.
  final String location;

  /// The location description of the itinerary.
  final String locationDescription;

  /// The list of guests for the itinerary.
  final List<Guest> guests;

  /// The file id of the itinerary
  final String? fileId;

  /// The user creator of the itinerary.
  final UserCreator? userCreator;

  /// Creates a copy of this [ItineraryModel] instance with the specified properties replaced.
  ///
  /// The [name], [transportation], [startDate], [endDate], [location], and [guests] parameters are optional and represent the properties to replace.
  ///
  /// Returns a new [ItineraryModel] instance with the specified properties replaced.
  ItineraryModel copyWith({
    String? name,
    String? transportation,
    String? locationDescription,
    String? startDate,
    String? endDate,
    String? location,
    List<Guest>? guests,
    UserCreator? userCreator,
    String? fileId,
  }) {
    return ItineraryModel(
      name: name ?? this.name,
      transportation: transportation ?? this.transportation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      locationDescription: locationDescription ?? this.locationDescription,
      guests: guests ?? this.guests,
      userCreator: userCreator ?? this.userCreator,
      fileId: fileId ?? this.fileId,
    );
  }

  /// Converts this [ItineraryModel] instance to a map.
  ///
  /// Returns a map representation of this [ItineraryModel] instance.
  Map<String, dynamic> toMap() {
    final guests = this.guests.map((x) => x.toMap()).toList();

    final data = <String, dynamic>{
      'name': name,
      'transportation': transportation,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'locationDescription': locationDescription,
    };

    if (guests.isNotEmpty) {
      data['guest'] = guests;
    }

    if (fileId != null) {
      data['fileId'] = fileId;
    }

    return data;
  }
}
