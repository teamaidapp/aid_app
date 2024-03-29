import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/features/calendar/entities/event.model.dart';
import 'package:team_aid/features/teams/entities/contact.model.dart';
import 'package:team_aid/features/travels-legacy/entities/hotel.model.dart';
import 'package:team_aid/features/travels-legacy/entities/itinerary.model.dart';
import 'package:team_aid/features/travels-legacy/entities/user_files.model.dart';

/// State of the travels screen
@immutable
class TravelsScreenState {
  /// Constructor
  const TravelsScreenState({
    required this.contactList,
    required this.itineraryList,
    required this.hotelList,
    required this.filesList,
    required this.calendarEvents,
    required this.fileId,
  });

  /// The function returns a new instance of the TravelsScreenState class with updated contactList if
  /// provided, otherwise it returns the current instance.
  ///
  /// Args:
  ///   contactList (AsyncValue<List<ContactModel>>): `contactList` is an optional parameter of type
  /// `AsyncValue<List<ContactModel>>`. It is used in the `copyWith` method of the `TravelsScreenState`
  /// class to create a new instance of the class with updated values. If `contactList` is not provided,
  /// the method
  ///
  /// Returns:
  ///   The `copyWith` method is returning a new instance of `TravelsScreenState` with updated values.
  /// It takes an optional parameter `contactList` of type `AsyncValue<List<ContactModel>>` and returns
  /// a new instance of `TravelsScreenState` with the same values as the current instance, except for
  /// the `contactList` parameter which is updated with the new value if it is
  TravelsScreenState copyWith({
    AsyncValue<List<ContactModel>>? contactList,
    AsyncValue<List<ItineraryLegacyModel>>? itineraryList,
    AsyncValue<List<HotelModel>>? hotelList,
    AsyncValue<List<UserFiles>>? filesList,
    AsyncValue<List<CalendarEvent>>? calendarEvents,
    String? fileId,
  }) {
    return TravelsScreenState(
      contactList: contactList ?? this.contactList,
      itineraryList: itineraryList ?? this.itineraryList,
      hotelList: hotelList ?? this.hotelList,
      filesList: filesList ?? this.filesList,
      calendarEvents: calendarEvents ?? this.calendarEvents,
      fileId: fileId ?? this.fileId,
    );
  }

  /// The contact list
  final AsyncValue<List<ContactModel>> contactList;

  /// The itinerary list
  final AsyncValue<List<ItineraryLegacyModel>> itineraryList;

  /// The hotel list
  final AsyncValue<List<HotelModel>> hotelList;

  /// The files list
  final AsyncValue<List<UserFiles>> filesList;

  /// The list of calendar events
  final AsyncValue<List<CalendarEvent>> calendarEvents;

  /// The file id that was uploaded to the server
  /// this is populated by the response of the server
  final String fileId;
}
