// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/main.dart';


/// The provider of HomeRepository
final homeProvider = Provider<HomeRepository>((ref) {
  final http = ref.watch(httpProvider);
  return HomeRepositoryImpl(http);
});

/// This class is responsible of the abstraction
abstract class HomeRepository {  
  /// Get data
  Future<Either<Failure, Success>> getData();

}

/// This class is responsible for implementing the HomeRepository
class HomeRepositoryImpl implements HomeRepository {

  /// Constructor
  HomeRepositoryImpl(this.http);

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
          message: 'Hubo un error en HomeRepositoyImpl',
        ),
      );
    }
  }
}
