// ignore_for_file: one_member_abstracts
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/features/calendar/repositories/calendar.repository.dart';
import 'package:team_aid/features/teams/entities/contact.model.dart';
import 'package:team_aid/features/teams/repositories/teams.repository.dart';
import 'package:team_aid/features/travels/entities/hotel.model.dart';
import 'package:team_aid/features/travels/entities/itinerary.model.dart';
import 'package:team_aid/features/travels/entities/user_files.model.dart';
import 'package:team_aid/features/travels/repositories/travels.repository.dart';

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
    required ItineraryModel itinerary,
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
  Future<Either<Failure, List<ItineraryModel>>> getItinerary();

  /// Get the hotels
  Future<Either<Failure, List<HotelModel>>> getHotels();

  /// Upload a file
  Future<Either<Failure, Success>> uploadFile({required File file});
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
          message: 'Hubo un problema al obtener los datos de TravelsServiceImpl',
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
    required ItineraryModel itinerary,
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
          message: 'Hubo un problema al obtener los datos de CalendarServiceImpl',
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
          message: 'Hubo un problema al obtener los datos de TeamsServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ItineraryModel>>> getItinerary() async {
    try {
      final result = await travelsRepository.getItinerary();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un problema al obtener los datos de TravelsServiceImpl',
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
          message: 'Hubo un problema al obtener los datos de TravelsServiceImpl',
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
          message: 'Hubo un problema al obtener los datos de TravelsServiceImpl',
        ),
      );
    }
  }
}
