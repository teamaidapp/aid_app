// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required this.placeDescription,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.reservationCode,
    required this.guests,
    this.fileId,
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
      description: map['description'] as String,
    );
  }

  /// Creates a copy of this [HotelModel] instance with the specified properties replaced.
  ///
  /// The [place], [startDate], [endDate], and [reservationCode] parameters are optional and represent the properties to replace.
  ///
  /// Returns a new [HotelModel] instance with the specified properties replaced.
  HotelModel copyWith({
    String? place,
    String? placeDescription,
    String? description,
    String? startDate,
    String? endDate,
    String? reservationCode,
    String? fileId,
    List<Guest>? guests,
  }) {
    return HotelModel(
      place: place ?? this.place,
      placeDescription: placeDescription ?? this.placeDescription,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reservationCode: reservationCode ?? this.reservationCode,
      fileId: fileId ?? this.fileId,
      guests: guests ?? this.guests,
    );
  }

  /// Converts this [HotelModel] instance to a map.
  ///
  /// Returns a map representation of this [HotelModel] instance.
  Map<String, dynamic> toMap() {
    final guest = guests.map((x) => x.toMap()).toList();
    final data = <String, dynamic>{
      'place': place,
      'startDate': startDate,
      'endDate': endDate,
      'placeDescription': placeDescription,
      'reservation_code': reservationCode,
      'guest': guest,
      'description': description,
    };

    if (fileId != null) {
      data['fileId'] = fileId;
    }
    return data;
  }

  @override
  String toString() {
    return 'HotelModel(place: $place, startDate: $startDate, endDate: $endDate, reservation_code: $reservationCode)';
  }

  /// The name of the hotel.
  final String place;

  /// The description location of the hotel.
  final String placeDescription;

  /// The description of the hotel.
  final String description;

  /// The start date of the reservation.
  final String startDate;

  /// The end date of the reservation.
  final String endDate;

  /// The reservation code.
  final String reservationCode;

  /// The File ID of the reservation.
  final String? fileId;

  /// The list of guests for the hotel.
  final List<Guest> guests;
}
