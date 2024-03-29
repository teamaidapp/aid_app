// ignore_for_file: one_member_abstracts
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/calendar/entities/event.model.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/features/calendar/repositories/calendar.repository.dart';
import 'package:team_aid/features/teams/entities/contact.model.dart';
import 'package:team_aid/features/teams/repositories/teams.repository.dart';
import 'package:team_aid/features/travels-legacy/entities/hotel.model.dart';
import 'package:team_aid/features/travels-legacy/entities/itinerary.model.dart';
import 'package:team_aid/features/travels-legacy/entities/user_files.model.dart';
import 'package:team_aid/features/travels-legacy/repositories/travels-legacy.repository.dart';

/// The provider of TravelsService
final travelsServiceProvider = Provider<TravelsServiceImpl>((ref) {
  final travelsRepository = ref.watch(travelsProvider);
  final calendarRepository = ref.watch(calendarProvider);
  final teamsRepository = ref.watch(teamsProvider);
  return TravelsServiceImpl(
    travelsRepository,
    calendarRepository,
    teamsRepository,
  );
});

/// This class is responsible of the abstraction
abstract class TravelsService {
  /// Get files
  Future<Either<Failure, List<UserFiles>>> getFiles();

  /// Add itinerary
  Future<Either<Failure, Success>> addItinerary({
    required ItineraryLegacyModel itinerary,
  });

  /// Add hotel
  Future<Either<Failure, Success>> addHotel({
    required HotelModel hotel,
  });

  /// Add event
  Future<Either<Failure, Success>> addSchedule(
    ScheduleModel schedule,
  );

  /// Get data
  Future<Either<Failure, List<ContactModel>>> getContactList({
    required String teamId,
  });

  /// Get the itineraries
  Future<Either<Failure, List<ItineraryLegacyModel>>> getItinerary();

  /// Get the hotels
  Future<Either<Failure, List<HotelModel>>> getHotels();

  /// Upload a file
  Future<Either<Failure, Success>> uploadFile({required File file});

  /// Patch a file
  Future<Either<Failure, Success>> patchFile({
    required String fileId,
    required String description,
    required List<Guest> guests,
  });

  /// Get data
  Future<Either<Failure, List<CalendarEvent>>> getCalendarData();
}

/// This class is responsible for implementing the TravelsService
class TravelsServiceImpl implements TravelsService {
  /// Constructor
  TravelsServiceImpl(
    this.travelsRepository,
    this.calendarRepository,
    this.teamsRepository,
  );

  /// The travels Repository that is injected
  final TravelsRepository travelsRepository;

  /// The calendar Repository that is injected
  final CalendarRepository calendarRepository;

  /// The teams Repository that is injected
  final TeamsRepository teamsRepository;

  @override
  Future<Either<Failure, List<UserFiles>>> getFiles() async {
    try {
      final result = await travelsRepository.getFiles();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TravelsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CalendarEvent>>> getCalendarData() async {
    try {
      final result = await calendarRepository.getCalendarData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with CalendarServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> addHotel({
    required HotelModel hotel,
  }) async {
    try {
      final result = await travelsRepository.addHotel(hotel: hotel);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un problema al agregar el hotel en TravelsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> addItinerary({
    required ItineraryLegacyModel itinerary,
  }) async {
    try {
      final result = await travelsRepository.addItinerary(itinerary: itinerary);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un problema al agregar el itinerario en TravelsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> addSchedule(ScheduleModel schedule) async {
    try {
      final result = await calendarRepository.addSchedule(schedule);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with CalendarServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getContactList({
    required String teamId,
  }) async {
    try {
      final result = await teamsRepository.getContactList(teamId: teamId);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TeamsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ItineraryLegacyModel>>> getItinerary() async {
    try {
      final result = await travelsRepository.getItinerary();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TravelsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<HotelModel>>> getHotels() async {
    try {
      final result = await travelsRepository.getHotels();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TravelsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> uploadFile({
    required File file,
  }) async {
    try {
      final result = await travelsRepository.uploadFile(file: file);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TravelsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> patchFile({
    required String fileId,
    required String description,
    required List<Guest> guests,
  }) async {
    try {
      final result = await travelsRepository.patchFile(
        fileId: fileId,
        description: description,
        guests: guests,
      );

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TravelsServiceImpl',
        ),
      );
    }
  }
}
