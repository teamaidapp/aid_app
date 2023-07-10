import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/teams/services/teams.service.dart';
import 'package:team_aid/features/travels/entities/hotel.model.dart';
import 'package:team_aid/features/travels/entities/itinerary.model.dart';
import 'package:team_aid/features/travels/services/travels.service.dart';
import 'package:team_aid/features/travels/state/travels.state.dart';

/// A dependency injection.
final travelsControllerProvider = StateNotifierProvider.autoDispose<TravelsController, TravelsScreenState>((ref) {
  return TravelsController(
    const TravelsScreenState(
      contactList: AsyncValue.loading(),
      itineraryList: AsyncValue.loading(),
      hotelList: AsyncValue.loading(),
      filesList: AsyncValue.loading(),
    ),
    ref,
    ref.watch(travelsServiceProvider),
    ref.watch(teamsServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class TravelsController extends StateNotifier<TravelsScreenState> {
  /// Constructor
  TravelsController(
    super.state,
    this.ref,
    this._travelsService,
    this._teamsService,
  );

  /// Riverpod reference
  final Ref ref;

  final TravelsService _travelsService;

  final TeamsService _teamsService;

  /// This function adds an itinerary and returns a response indicating success or failure.
  ///
  /// Args:
  ///   itinerary (ItineraryModel): an object of type ItineraryModel that represents the itinerary to be
  /// added.
  ///
  /// Returns:
  ///   a `Future` of `ResponseFailureModel`.
  Future<ResponseFailureModel> addItinerary({
    required ItineraryModel itinerary,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.addItinerary(itinerary: itinerary);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          await getItineraries();
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de TravelsService',
      );
    }
  }

  /// This function adds a hotel to the travel service and returns a response indicating success or
  /// failure.
  ///
  /// Args:
  ///   hotel (HotelModel): The `hotel` parameter is a required `HotelModel` object that contains the
  /// information of the hotel to be added.
  ///
  /// Returns:
  ///   a `Future` of `ResponseFailureModel`.
  Future<ResponseFailureModel> addHotel({required HotelModel hotel}) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.addHotel(hotel: hotel);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          await getHotels();
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de TravelsService',
      );
    }
  }

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getContactList({required String teamId}) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _teamsService.getContactList(teamId: teamId);

      state = state.copyWith(contactList: const AsyncValue.loading());

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (list) {
          state = state.copyWith(
            contactList: AsyncValue.data(list),
          );
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de TeamsService',
      );
    }
  }

  /// The function `getItineraries` retrieves a list of itineraries from a travel service and updates the
  /// state accordingly.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getItineraries() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.getItinerary();

      state = state.copyWith(contactList: const AsyncValue.loading());

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (list) {
          state = state.copyWith(
            itineraryList: AsyncValue.data(list),
          );
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de TeamsService',
      );
    }
  }

  /// The function `getItineraries` retrieves a list of itineraries from a travel service and updates the
  /// state accordingly.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getHotels() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.getHotels();

      state = state.copyWith(contactList: const AsyncValue.loading());

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (list) {
          state = state.copyWith(
            hotelList: AsyncValue.data(list),
          );
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de TeamsService',
      );
    }
  }

  /// Upload the file
  Future<ResponseFailureModel> uploadFile({
    required File file,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.uploadFile(file: file);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          await getFiles();
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de TravelsService',
      );
    }
  }

  /// Get the files
  Future<ResponseFailureModel> getFiles() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.getFiles();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          state = state.copyWith(
            filesList: AsyncValue.data(success),
          );
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'Hubo un problema al obtener los datos de TravelsService',
      );
    }
  }
}
