// ignore_for_file: one_member_abstracts
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as multi_http;
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/calendar/entities/calender_invitation.model.dart';
import 'package:team_aid/features/calendar/entities/event.model.dart';
import 'package:team_aid/features/calendar/entities/event_shared.model.dart';
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

  /// Get shared calendars
  Future<Either<Failure, List<EventShared>>> getSharedCalendars();

  /// Add schedule
  Future<Either<Failure, Success>> addSchedule(
    ScheduleModel schedule,
  );

  /// Get calendar invitations
  Future<Either<Failure, List<CalendarInvitationModel>>> getCalendarInvitations();

  /// Change status of invitation
  Future<Either<Failure, Success>> changeStatusInvitation({
    required String id,
    required String status,
  });

  /// Share calendar
  Future<Either<Failure, Success>> shareCalendar({required String email});

  /// Upload a file
  Future<Either<Failure, Success>> uploadFile({required File file});

  /// Patch a file
  Future<Either<Failure, Success>> patchFile({
    required String fileId,
    required String description,
    required List<Guest> guests,
  });
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
  Future<Either<Failure, List<EventShared>>> getSharedCalendars() async {
    final list = <EventShared>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/calendar/share-calendar',
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
          if (element['inviterUser'] != null) {
            final event = CalendarEvent.fromMap(
              map: element as Map<String, dynamic>,
              key: key.toString(),
            );
            final sharedEvent = EventShared(
              id: event.id,
              isOwner: event.isOwner,
              status: event.status,
              event: event.event,
              dateKey: event.dateKey,
              inviteUser: InviteUserModel.fromMap(
                element['inviterUser'] as Map<String, dynamic>,
              ),
            );
            list.add(sharedEvent);
          }
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
          message: 'There was an error with CalendarRepositoyImpl',
        ),
      );
    }
  }

  /// Get data from backend
  @override
  Future<Either<Failure, List<CalendarInvitationModel>>> getCalendarInvitations() async {
    final list = <CalendarInvitationModel>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/calendar/share-calendar-pending',
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
      final tmpList = (jsonDecode(res.body) as Map)['data'] as List;
      for (final element in tmpList) {
        final event = CalendarInvitationModel.fromMap(
          element as Map<String, dynamic>,
        );
        list.add(event);
      }
      return Right(list);
    } catch (e) {
      return const Right([]);
    }
  }

  @override
  Future<Either<Failure, Success>> changeStatusInvitation({
    required String id,
    required String status,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/calendar/share-calendar/$id',
      );
      final res = await http.patch(
        url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'status': status,
          },
        ),
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while fetching the data',
          ),
        );
      }
      return Right(Success(ok: true, message: 'Event status changed'));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CalendarRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> shareCalendar({
    required String email,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/calendar/share-calendar',
      );
      final res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'id': email,
          },
        ),
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while sharing the calendar',
          ),
        );
      }
      return Right(Success(ok: true, message: 'Event status changed'));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CalendarRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> uploadFile({
    required File file,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/file',
      );
      final request = multi_http.MultipartRequest('POST', url);

      final headers = <String, String>{'Authorization': 'Bearer $token', 'Content-type': 'multipart/form-data'};
      request.files.add(
        multi_http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );
      request.headers.addAll(headers);

      final res = await request.send();
      // final res = await multipartRequest(
      //   url,
      //   headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      // );
      // multipartRequest.headers['Authorization'] = 'Bearer $token';
      // multipartRequest.headers['Content-Type'] = 'multipart/form-data';
      // multipartRequest.fields['file'] = 'value1';
      // multipartRequest.files.add(await MultipartFile.fromPath('file', file.path));

      // final res = await http.send(multipartRequest);

      // multipartRequest.finalize();

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while uploading the file',
          ),
        );
      }

      final response = await multi_http.Response.fromStream(res);

      final data = (jsonDecode(response.body) as Map<String, dynamic>)['data'] as Map<String, dynamic>;

      return Right(Success(ok: true, message: data['id'] as String));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CalendarRepositoyImpl',
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
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/file',
      );
      final res = await http.patch(
        url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: jsonEncode({
          'fileId': fileId,
          'description': description,
          'guest': guests.map((e) => e.toMap()).toList(),
        }),
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while uploading the file',
          ),
        );
      }

      final data = (jsonDecode(res.body) as Map<String, dynamic>)['data'] as Map<String, dynamic>;
      return Right(Success(ok: true, message: data['fileKey'] as String));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CalendarRepositoryImpl',
        ),
      );
    }
  }
}
