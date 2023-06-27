import 'package:team_aid/core/entities/guest.model.dart';

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
  const ItineraryModel({
    required this.name,
    required this.transportation,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.guests,
  });

  /// Creates a new instance of [ItineraryModel] from a map.
  ///
  /// The [map] parameter is required and represents the map to convert to an [ItineraryModel] instance.
  factory ItineraryModel.fromMap(Map<String, dynamic> map) {
    return ItineraryModel(
      name: map['name'] as String,
      transportation: map['transportation'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      location: map['location'] as String,
      guests: List<Guest>.from(
        (map['guests'] as List<int>).map<Guest>(
          (x) => Guest.fromMap(x as Map<String, dynamic>),
        ),
      ),
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

  /// The list of guests for the itinerary.
  final List<Guest> guests;

  /// Creates a copy of this [ItineraryModel] instance with the specified properties replaced.
  ///
  /// The [name], [transportation], [startDate], [endDate], [location], and [guests] parameters are optional and represent the properties to replace.
  ///
  /// Returns a new [ItineraryModel] instance with the specified properties replaced.
  ItineraryModel copyWith({
    String? name,
    String? transportation,
    String? startDate,
    String? endDate,
    String? location,
    List<Guest>? guests,
  }) {
    return ItineraryModel(
      name: name ?? this.name,
      transportation: transportation ?? this.transportation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      guests: guests ?? this.guests,
    );
  }

  /// Converts this [ItineraryModel] instance to a map.
  ///
  /// Returns a map representation of this [ItineraryModel] instance.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'transportation': transportation,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'guests': guests.map((x) => x.toMap()).toList(),
    };
  }
}
