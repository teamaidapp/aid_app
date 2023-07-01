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
  });

  /// Creates a new instance of [HotelModel] from a map.
  ///
  /// The [map] parameter is required and represents the map to convert to a [HotelModel] instance.
  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      place: map['place'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      reservationCode: map['reservationCode'] as String,
      guests: List<Guest>.from(
        (map['guests'] as List<int>).map<Guest>(
          (x) => Guest.fromMap(x as Map<String, dynamic>),
        ),
      ),
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
    String? reservationCode,
    List<Guest>? guests,
  }) {
    return HotelModel(
      place: place ?? this.place,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
      'reservationCode': reservationCode,
      'guest': guests.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'HotelModel(place: $place, startDate: $startDate, endDate: $endDate, reservation_code: $reservationCode)';
  }

  /// The name of the hotel.
  final String place;

  /// The start date of the reservation.
  final String startDate;

  /// The end date of the reservation.
  final String endDate;

  /// The reservation code.
  final String reservationCode;

  /// The list of guests for the hotel.
  final List<Guest> guests;
}
