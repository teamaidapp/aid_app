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

class CalendarModel {
  final String dayLabel;
  final int dayNumber;
  final List<EventHourModel> hours;

  CalendarModel({
    required this.dayLabel,
    required this.dayNumber,
    required this.hours,
  });
}
