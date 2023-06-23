import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/features/calendar/entities/event.model.dart';

/// State of the calendar screen
@immutable
class CalendarScreenState {
  /// Constructor
  const CalendarScreenState({
    required this.calendarEvents,
  });

  /// The function returns a new instance of the `CalendarScreenState` class with updated `calendarEvents`
  /// value if provided, otherwise it returns the current instance.
  ///
  /// Args:
  ///   calendarEvents (AsyncValue<List<CalendarEvent>>): `calendarEvents` is an optional parameter of
  /// type `AsyncValue<List<CalendarEvent>>`. It is used in the `copyWith` method of the
  /// `CalendarScreenState` class to create a new instance of the class with updated values. If a new
  /// value for `calendarEvents` is provided,
  ///
  /// Returns:
  ///   The `copyWith` method is returning a new instance of `CalendarScreenState` with updated values. If
  /// `calendarEvents` parameter is provided, it will replace the existing `calendarEvents` value with the
  /// new one. If `calendarEvents` parameter is not provided, it will keep the existing `calendarEvents`
  /// value.
  CalendarScreenState copyWith({
    AsyncValue<List<CalendarEvent>>? calendarEvents,
  }) {
    return CalendarScreenState(
      calendarEvents: calendarEvents ?? this.calendarEvents,
    );
  }

  /// The list of calendar events
  final AsyncValue<List<CalendarEvent>> calendarEvents;
}
