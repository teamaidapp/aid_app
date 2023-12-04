import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/entities/user_creator.model.dart';

/// A class representing an event.
class CalendarEvent {
  /// Creates a new instance of [CalendarEvent].
  ///
  /// The [id] parameter is required and represents the ID of the event.
  ///
  /// The [isOwner] parameter is required and indicates whether the current user is the owner of the event.
  ///
  /// The [status] parameter is required and represents the status of the event.
  ///
  /// The [event] parameter is required and represents the details of the event.
  ///
  /// The [dateKey] parameter is required and represents the date key of the event.
  const CalendarEvent({
    required this.id,
    required this.isOwner,
    required this.status,
    required this.event,
    required this.dateKey,
  });

  /// This is a factory constructor in Dart that creates a CalendarEvent object from a Map of key-value
  /// pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A Map object that contains key-value pairs representing the
  /// properties of a CalendarEvent object.
  ///
  /// Returns:
  ///   A `CalendarEvent` object is being returned.
  factory CalendarEvent.fromMap({
    required Map<String, dynamic> map,
    required String key,
  }) {
    return CalendarEvent(
      id: map['id'] as String,
      dateKey: key,
      isOwner: map['isOwner'] as bool,
      status: map['status'] as String,
      event: EventClass.fromMap(map['event'] as Map<String, dynamic>, map['guest'] as List<dynamic>?),
    );
  }

  /// The ID of the event.
  final String id;

  /// The date key of the event.
  final String dateKey;

  /// Indicates whether the current user is the owner of the event.
  final bool isOwner;

  /// The status of the event.
  final String status;

  /// The details of the event.
  final EventClass event;
}

/// A class representing the details of an event.
class EventClass {
  /// Creates a new instance of [EventClass].
  ///
  /// The [id] parameter is required and represents the ID of the event.
  ///
  /// The [eventName] parameter is required and represents the name of the event.
  ///
  /// The [eventDescription] parameter is required and represents the description of the event.
  ///
  /// The [startDate] parameter is required and represents the start date and time of the event.
  ///
  /// The [endDate] parameter is required and represents the end date and time of the event.
  ///
  /// The [status] parameter is required and represents the status of the event.
  ///
  /// The [location] parameter is required and represents the location of the event.
  ///
  /// The [createdAt] parameter is required and represents the date and time when the event was created.
  ///
  /// The [userCreator] parameter is optional and represents the user creator of the event.
  const EventClass({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.location,
    required this.createdAt,
    required this.guests,
    this.userCreator,
  });

  /// The fromMap constructor is used to create a new instance of [EventClass] from a map.
  factory EventClass.fromMap(Map<String, dynamic> map, List<dynamic>? guest) {
    return EventClass(
      id: map['id'] as String,
      eventName: map['eventName'] as String,
      eventDescription: map['eventDescription'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      status: map['status'] as String,
      location: map['location'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      userCreator: UserCreator2.fromMap(map['userCreator'] as Map<String, dynamic>),
      guests: guest?.map((e) => Guest.fromMap(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  /// The ID of the event.
  final String id;

  /// The name of the event.
  final String eventName;

  /// The description of the event.
  final String eventDescription;

  /// The start date and time of the event.
  final DateTime startDate;

  /// The end date and time of the event.
  final DateTime endDate;

  /// The status of the event.
  final String status;

  /// The location of the event.
  final String location;

  /// The date and time when the event was created.
  final DateTime createdAt;

  /// The list of guests for the itinerary.
  final List<Guest> guests;

  /// The user creator of the itinerary.
  final UserCreator2? userCreator;
}
