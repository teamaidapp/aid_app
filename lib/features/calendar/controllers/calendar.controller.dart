import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/features/calendar/services/calendar.service.dart';
import 'package:team_aid/features/calendar/state/calendar.state.dart';
import 'package:team_aid/features/teams/services/teams.service.dart';

/// A dependency injection.
final calendarControllerProvider = StateNotifierProvider.autoDispose<CalendarController, CalendarScreenState>((ref) {
  return CalendarController(
    const CalendarScreenState(
      contactList: AsyncValue.loading(),
      calendarEvents: AsyncValue.loading(),
      calendarInvitationsEvents: AsyncValue.loading(),
      sharedCalendar: AsyncValue.loading(),
    ),
    ref,
    ref.watch(calendarServiceProvider),
    ref.watch(teamsServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class CalendarController extends StateNotifier<CalendarScreenState> {
  /// Constructor
  CalendarController(
    super.state,
    this.ref,
    this._calendarService,
    this._teamsService,
  );

  /// Riverpod reference
  final Ref ref;

  final CalendarService _calendarService;

  final TeamsService _teamsService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getCalendarData() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _calendarService.getCalendarData();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          state = state.copyWith(calendarEvents: AsyncValue.data(success));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with CalendarService',
      );
    }
  }

  /// The function `getSharedCalendar` retrieves shared calendars and handles success and failure cases.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getSharedCalendar() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _calendarService.getSharedCalendars();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          state = state.copyWith(sharedCalendar: AsyncValue.data(success));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with CalendarService',
      );
    }
  }

  /// The function `getCalendarInvitations` retrieves calendar invitations and handles success and failure
  /// cases.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getCalendarInvitations() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _calendarService.getCalendarInvitations();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          state = state.copyWith(calendarInvitationsEvents: AsyncValue.data(success));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with CalendarService',
      );
    }
  }

  /// This function adds a schedule using a provided ScheduleModel and returns a ResponseFailureModel
  /// indicating success or failure.
  ///
  /// Args:
  ///   schedule (ScheduleModel): A required parameter of type ScheduleModel, which is used to add a new
  /// schedule to the calendar.
  ///
  /// Returns:
  ///   a `Future` that resolves to a `ResponseFailureModel` object.
  Future<ResponseFailureModel> addSchedule({
    required ScheduleModel schedule,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _calendarService.addSchedule(schedule);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with CalendarService',
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
        message: 'There was a problem with TeamsService',
      );
    }
  }

  /// The function `changeStatusInvitation` is a Dart function that takes an `id` and `status` as
  /// parameters, and uses the `_calendarService` to change the status of an invitation, returning a
  /// `ResponseFailureModel` object.
  ///
  /// Args:
  ///   id (String): The id parameter is a required String that represents the unique identifier of the
  /// invitation. It is used to identify the specific invitation that needs to have its status changed.
  ///   status (String): The "status" parameter is a required string that represents the new status of an
  /// invitation. It is used in the "_calendarService.changeStatusInvitation" method to update the status
  /// of the invitation with the specified "id".
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> changeStatusInvitation({
    required String id,
    required String status,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _calendarService.changeStatusInvitation(
        id: id,
        status: status,
      );

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          await getCalendarInvitations();
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with CalendarService',
      );
    }
  }

  /// The function `shareCalendar` is a Dart function that takes an `email` as a parameter, and uses the
  /// `_calendarService` to share a calendar, returning a `ResponseFailureModel` object.
  Future<ResponseFailureModel> shareCalendar({
    required String email,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _calendarService.shareCalendar(email: email);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) async {
          await getSharedCalendar();
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(
        message: 'There was a problem with CalendarService',
      );
    }
  }
}
