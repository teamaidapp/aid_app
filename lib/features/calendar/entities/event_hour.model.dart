import 'package:team_aid/features/calendar/entities/event.model.dart';

/// A class representing an event hour.
class EventHourModel {
  /// Creates a new instance of [EventHourModel].
  ///
  /// The [hour], [label], and [event] parameters are required and represent the properties of the event hour.
  const EventHourModel({
    required this.hour,
    required this.label,
    this.event,
  });

  /// Returns a string representation of this [EventHourModel] instance.
  @override
  String toString() {
    return 'EventHourModel(hour: $hour, label: $label, event: $event)';
  }

  /// The hour of the event.
  final String hour;

  /// The label of the event.
  final String label;

  /// The calendar event associated with the event hour.
  final List<CalendarEvent>? event;
}

/// The `CalendarModel` class represents a day in a calendar, with a day label, day number, and a list
/// of event hours.
class CalendarModel {
  /// Constructor
  const CalendarModel({
    required this.dayLabel,
    required this.dayNumber,
    required this.hours,
  });

  /// The day label
  final String dayLabel;

  /// The day number
  final int dayNumber;

  /// The list of hours
  final List<EventHourModel> hours;
}
