// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/calendar/repositories/calendar.repository.dart';

/// The provider of CalendarService
final calendarServiceProvider = Provider<CalendarServiceImpl>((ref) {
  final calendarRepository = ref.watch(calendarProvider);
  return CalendarServiceImpl(calendarRepository);
});

/// This class is responsible of the abstraction
abstract class CalendarService {
  /// Get data
  Future<Either<Failure, Success>> getData();
}

/// This class is responsible for implementing the CalendarService
class CalendarServiceImpl implements CalendarService {

  /// Constructor
  CalendarServiceImpl(this.calendarRepository);

  /// The calendar Repository that is injected
  final CalendarRepository calendarRepository;

  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      final result = await calendarRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(          
          message: 'Hubo un problema al obtener los datos de CalendarServiceImpl',
        ),
      );
    }
  }
}
