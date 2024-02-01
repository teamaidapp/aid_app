import 'package:team_aid/core/entities/guest.model.dart';

/// A class representing a schedule for an event.
class ScheduleModel {
  /// Creates a new instance of [ScheduleModel].
  ///
  /// The [eventName] parameter is required and represents the name of the event.
  ///
  /// The [startDate] parameter is required and represents the start date of the event.
  ///
  /// The [endDate] parameter is required and represents the end date of the event.
  ///
  /// The [location] parameter is required and represents the location of the event.
  ///
  /// The [eventDescription] parameter is required and represents the description of the event.
  ///
  /// The [guest] parameter is required and represents the list of guests for the event.
  ///
  /// The [periodicity] parameter is required and represents the periodicity of the event.
  ///
  /// The [locationDescription] parameter is required and represents the description of the location.
  ///
  /// The [fileId] parameter is optional and represents the fileId for the event.
  const ScheduleModel({
    required this.eventName,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.eventDescription,
    required this.guest,
    required this.periodicity,
    required this.locationDescription,
    this.fileId,
  });

  /// Converts this [ScheduleModel] instance to a map.
  ///
  /// Returns a map representation of this [ScheduleModel] instance.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'eventDescription': eventDescription,
      'guest': guest.map((x) => x.toMap()).toList(),
      'periodicity': periodicity,
      'locationDescription': locationDescription,
      'fileId': fileId,
    };
  }

  /// The name of the event.
  final String eventName;

  /// The start date of the event.
  final String startDate;

  /// The end date of the event.
  final String endDate;

  /// The location of the event.
  final String location;

  /// The description of the location.
  final String locationDescription;

  /// The description of the event.
  final String eventDescription;

  /// The list of guests for the event.
  final List<Guest> guest;

  /// The periodicity of the event.
  final String periodicity;

  /// A list of files for the event.
  final String? fileId;
}
