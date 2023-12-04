// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/calendar/entities/calender_invitation.model.dart';
import 'package:team_aid/features/calendar/entities/event.model.dart';
import 'package:team_aid/features/calendar/entities/event_shared.model.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/features/calendar/repositories/calendar.repository.dart';

/// The provider of CalendarService
final calendarServiceProvider = Provider<CalendarServiceImpl>((ref) {
  final calendarRepository = ref.watch(calendarProvider);
  return CalendarServiceImpl(calendarRepository);
});

/// This class is responsible of the abstraction
abstract class CalendarService {
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
}

/// This class is responsible for implementing the CalendarService
class CalendarServiceImpl implements CalendarService {
  /// Constructor
  CalendarServiceImpl(this.calendarRepository);

  /// The calendar Repository that is injected
  final CalendarRepository calendarRepository;

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
  Future<Either<Failure, List<CalendarInvitationModel>>> getCalendarInvitations() async {
    try {
      final result = await calendarRepository.getCalendarInvitations();

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
  Future<Either<Failure, Success>> changeStatusInvitation({
    required String id,
    required String status,
  }) async {
    try {
      final result = await calendarRepository.changeStatusInvitation(id: id, status: status);

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
  Future<Either<Failure, List<EventShared>>> getSharedCalendars() async {
    try {
      final result = await calendarRepository.getSharedCalendars();

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
  Future<Either<Failure, Success>> shareCalendar({
    required String email,
  }) async {
    try {
      final result = await calendarRepository.shareCalendar(email: email);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with CalendarServiceImpl',
        ),
      );
    }
  }
}
