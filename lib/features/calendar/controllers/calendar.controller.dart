import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/features/calendar/services/calendar.service.dart';
import 'package:team_aid/features/calendar/state/calendar.state.dart';

/// A dependency injection.
final calendarControllerProvider =
    StateNotifierProvider.autoDispose<CalendarController, CalendarScreenState>(
        (ref) {
  return CalendarController(
    const CalendarScreenState(
      calendarEvents: AsyncValue.loading(),
    ),
    ref,
    ref.watch(calendarServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class CalendarController extends StateNotifier<CalendarScreenState> {
  /// Constructor
  CalendarController(super.state, this.ref, this._calendarService);

  /// Riverpod reference
  final Ref ref;

  final CalendarService _calendarService;

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
        message: 'Hubo un problema al obtener los datos de CalendarService',
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
        message: 'Hubo un problema al obtener los datos de CalendarService',
      );
    }
  }
}
