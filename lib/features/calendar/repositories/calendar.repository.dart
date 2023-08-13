// ignore_for_file: one_member_abstracts
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/calendar/entities/event.model.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/main.dart';

/// The provider of CalendarRepository
final calendarProvider = Provider<CalendarRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return CalendarRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class CalendarRepository {
  /// Get data
  Future<Either<Failure, List<CalendarEvent>>> getCalendarData();

  /// Add schedule
  Future<Either<Failure, Success>> addSchedule(
    ScheduleModel schedule,
  );
}

/// This class is responsible for implementing the CalendarRepository
class CalendarRepositoryImpl implements CalendarRepository {
  /// Constructor
  CalendarRepositoryImpl(this.http, this.secureStorage);

  /// The http client
  final Client http;

  /// The secure storage
  final FlutterSecureStorage secureStorage;

  /// Get data from backend
  @override
  Future<Either<Failure, List<CalendarEvent>>> getCalendarData() async {
    final list = <CalendarEvent>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/calendar/get-events',
      );
      final res = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while fetching the data',
          ),
        );
      }
      ((jsonDecode(res.body) as Map)['data'] as Map).forEach((key, value) {
        for (final element in value as List) {
          final event = CalendarEvent.fromMap(
            map: element as Map<String, dynamic>,
            key: key.toString(),
          );
          list.add(event);
        }
      });
      return Right(list);
    } catch (e) {
      return const Right([]);
    }
  }

  @override
  Future<Either<Failure, Success>> addSchedule(
    ScheduleModel schedule,
  ) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/calendar/create-event',
      );
      final res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: jsonEncode(schedule.toMap()),
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while fetching the data',
          ),
        );
      }
      return Right(Success(ok: true, message: 'Event created'));
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en CalendarRepositoyImpl',
        ),
      );
    }
  }
}
