import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/features/teams/entities/contact.model.dart';
import 'package:team_aid/features/travels/entities/travel.model.dart';
import 'package:team_aid/features/travels/entities/travel_api.model.dart';

/// State of the travels screen
@immutable
class TravelsScreenState {
  /// Constructor
  const TravelsScreenState({
    required this.contactList,
    required this.fileId,
    required this.travelModel,
    required this.travels,
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
    String? fileId,
    TravelModel? travelModel,
    AsyncValue<List<TravelAPIModel>>? travels,
  }) {
    return TravelsScreenState(
      contactList: contactList ?? this.contactList,
      fileId: fileId ?? this.fileId,
      travelModel: travelModel ?? this.travelModel,
      travels: travels ?? this.travels,
    );
  }

  /// The contact list
  final AsyncValue<List<ContactModel>> contactList;

  /// The file id that was uploaded to the server
  /// this is populated by the response of the server
  final String fileId;

  /// The model to be used in the API
  final TravelModel travelModel;

  /// The list of travels
  final AsyncValue<List<TravelAPIModel>> travels;
}
