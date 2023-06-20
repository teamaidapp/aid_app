// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/main.dart';


/// The provider of CalendarRepository
final calendarProvider = Provider<CalendarRepository>((ref) {
  final http = ref.watch(httpProvider);
  return CalendarRepositoryImpl(http);
});

/// This class is responsible of the abstraction
abstract class CalendarRepository {  
  /// Get data
  Future<Either<Failure, Success>> getData();

}

/// This class is responsible for implementing the CalendarRepository
class CalendarRepositoryImpl implements CalendarRepository {

  /// Constructor
  CalendarRepositoryImpl(this.http);

  /// The http client
  final Client http;

  /// Get data from backend
  @override
  Future<Either<Failure, Success>> getData() async {
    try {              
      return Right(Success(ok: true, message: 'Success'));
    } catch (e) {                          
      return Left(
        Failure(          
          message: 'Hubo un error en CalendarRepositoyImpl',
        ),
      );
    }
  }
}
