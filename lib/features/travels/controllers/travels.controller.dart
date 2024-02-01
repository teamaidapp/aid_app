import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/teams/services/teams.service.dart';
import 'package:team_aid/features/travels/entities/travel.model.dart';
import 'package:team_aid/features/travels/services/travels.service.dart';
import 'package:team_aid/features/travels/state/travels.state.dart';

/// A dependency injection.
final travelsControllerProvider = StateNotifierProvider.autoDispose<TravelsController, TravelsScreenState>((ref) {
  return TravelsController(
    const TravelsScreenState(
      contactList: AsyncValue.loading(),
      fileId: '',
      travels: AsyncValue.loading(),
      travelModel: TravelModel(
        name: '',
        transportation: '',
        startDate: '',
        endDate: '',
        location: '',
        locationDescription: '',
        files: [],
        hotel: '',
        hotelGoogle: '',
        arrivalDate: '',
        departureDate: '',
      ),
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

  void setTravelName({required String name}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(name: name),
    );
  }

  void setTravelTransportation({required String transportation}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(transportation: transportation),
    );
  }

  void setTravelStartDate({required String startDate}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(startDate: startDate),
    );
  }

  void setTravelEndDate({required String endDate}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(endDate: endDate),
    );
  }

  void setTravelLocation({required String location}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(location: location),
    );
  }

  void setTravelLocationDescription({required String locationDescription}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(locationDescription: locationDescription),
    );
  }

  void setTravelFiles({required List<TravelFile> files}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(files: files),
    );
  }

  void setTravelHotel({required String hotel}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(hotel: hotel),
    );
  }

  void setTravelHotelGoogle({required String hotelGoogle}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(hotelGoogle: hotelGoogle),
    );
  }

  void setFilesIds({required List<TravelFile> filesIds}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(files: filesIds),
    );
  }

  void setTravelArrivalDate({required String arrivalDate}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(arrivalDate: arrivalDate),
    );
  }

  void setTravelDepartureDate({required String departureDate}) {
    state = state.copyWith(
      travelModel: state.travelModel.copyWith(departureDate: departureDate),
    );
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
        (failure) {
          state = state.copyWith(contactList: const AsyncValue.data([]));
          return response = response.copyWith(message: failure.message);
        },
        (list) {
          state = state.copyWith(
            contactList: AsyncValue.data(list),
          );
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with TeamsService',
      );
    }
  }

  /// Upload the file
  Future<ResponseFailureModel> uploadFile({
    required File file,
    bool isAgnostic = false,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.uploadFile(file: file);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          if (!isAgnostic) state = state.copyWith(fileId: success.message);
          return response = response.copyWith(ok: true, message: success.message);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with TravelsService',
      );
    }
  }

  /// Patch the uploaded file
  Future<ResponseFailureModel> patchFile({
    required String description,
    required String fileId,
    required List<Guest> guests,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _travelsService.patchFile(description: description, fileId: fileId, guests: guests);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with TravelsService',
      );
    }
  }

  /// The function sets the fileId property in the state object.
  ///
  /// Args:
  ///   fileId (String): The `fileId` parameter is a required `String` that represents the unique
  /// identifier of a file.
  void setFileId({required String fileId}) {
    state = state.copyWith(fileId: fileId);
  }

  /// Create a travel
  Future<ResponseFailureModel> createTravel() async {
    var response = ResponseFailureModel.defaultFailureResponse();

    try {
      final result = await _travelsService.createTravel(travel: state.travelModel);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with TravelsService',
      );
    }
  }

  Future<ResponseFailureModel> getTravels() async {
    var response = ResponseFailureModel.defaultFailureResponse();

    try {
      final result = await _travelsService.getTravels();

      return result.fold(
        (failure) {
          state = state.copyWith(travels: const AsyncValue.data([]));
          return response = response.copyWith(message: failure.message);
        },
        (list) async {
          state = state.copyWith(
            travels: AsyncValue.data(list),
          );
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with TravelsService',
      );
    }
  }
}
