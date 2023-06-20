/// A class representing a date with associated events.
class EventDate {
  /// Creates a new instance of [EventDate].
  ///
  /// The [date] parameter is required and represents the date associated with this event date.
  ///
  /// The [events] parameter is required and represents the list of events associated with this event date.
  EventDate({
    required this.date,
    required this.events,
  });

  /// The date associated with this event date.
  final DateTime date;

  /// The list of events associated with this event date.
  final List<Event> events;
}

/// A class representing an event.
class Event {
  /// Creates a new instance of [Event].
  ///
  /// The [eventName] parameter is required and represents the name of the event.
  ///
  /// The [eventDescription] parameter is required and represents the description of the event.
  ///
  /// The [startDate] parameter is required and represents the start date and time of the event.
  ///
  /// The [endDate] parameter is required and represents the end date and time of the event.
  ///
  /// The [location] parameter is required and represents the location of the event.
  ///
  /// The [status] parameter is required and represents the status of the event.
  const Event({
    required this.eventName,
    required this.eventDescription,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.status,
  });

  /// The name of the event.
  final String eventName;

  /// The description of the event.
  final String eventDescription;

  /// The start date and time of the event.
  final DateTime startDate;

  /// The end date and time of the event.
  final DateTime endDate;

  /// The location of the event.
  final String location;

  /// The status of the event.
  final String status;
}
