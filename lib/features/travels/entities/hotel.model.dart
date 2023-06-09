import 'package:team_aid/core/entities/guest.model.dart';

/// A class representing a hotel reservation.
class HotelModel {
  /// Creates a new instance of [HotelModel].
  ///
  /// The [place] parameter is required and represents the name of the hotel.
  ///
  /// The [startDate] parameter is required and represents the start date of the reservation.
  ///
  /// The [endDate] parameter is required and represents the end date of the reservation.
  ///
  /// The [reservationCode] parameter is required and represents the reservation code.
  const HotelModel({
    required this.place,
    required this.startDate,
    required this.endDate,
    required this.reservationCode,
    required this.guests,
    required this.placeDescription,
  });

  /// Creates a new instance of [HotelModel] from a map.
  ///
  /// The [map] parameter is required and represents the map to convert to a [HotelModel] instance.
  factory HotelModel.fromMap(Map<String, dynamic> map, List<dynamic> guests) {
    return HotelModel(
      place: map['place'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      placeDescription: map['placeDescription'] as String,
      reservationCode: map['reservation_code'] as String,
      guests: guests.map((x) => Guest.fromMap(x as Map<String, dynamic>)).toList(),
    );
  }

  /// Creates a copy of this [HotelModel] instance with the specified properties replaced.
  ///
  /// The [place], [startDate], [endDate], and [reservationCode] parameters are optional and represent the properties to replace.
  ///
  /// Returns a new [HotelModel] instance with the specified properties replaced.
  HotelModel copyWith({
    String? place,
    String? startDate,
    String? endDate,
    String? placeDescription,
    String? reservationCode,
    List<Guest>? guests,
  }) {
    return HotelModel(
      place: place ?? this.place,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      placeDescription: placeDescription ?? this.placeDescription,
      reservationCode: reservationCode ?? this.reservationCode,
      guests: guests ?? this.guests,
    );
  }

  /// Converts this [HotelModel] instance to a map.
  ///
  /// Returns a map representation of this [HotelModel] instance.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'place': place,
      'startDate': startDate,
      'endDate': endDate,
      'placeDescription': placeDescription,
      'reservation_code': reservationCode,
      'guest': guests.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'HotelModel(place: $place, startDate: $startDate, endDate: $endDate, reservation_code: $reservationCode)';
  }

  /// The name of the hotel.
  final String place;

  /// The description of the hotel.
  final String placeDescription;

  /// The start date of the reservation.
  final String startDate;

  /// The end date of the reservation.
  final String endDate;

  /// The reservation code.
  final String reservationCode;

  /// The list of guests for the hotel.
  final List<Guest> guests;
}
