// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/main.dart';


/// The provider of {{#pascalCase}}{{name}} Repository {{/pascalCase}}
final {{#camelCase}}{{name}} Provider {{/camelCase}} = Provider<{{#pascalCase}}{{name}} Repository {{/pascalCase}}>((ref) {
  final http = ref.watch(httpProvider);
  return {{#pascalCase}}{{name}} RepositoryImpl {{/pascalCase}}(http);
});

/// This class is responsible of the abstraction
abstract class {{#pascalCase}}{{name}} Repository {{/pascalCase}} {  
  /// Get data
  Future<Either<Failure, Success>> getData();

}

/// This class is responsible for implementing the {{#pascalCase}}{{name}} Repository {{/pascalCase}}
class {{#pascalCase}}{{name}} RepositoryImpl {{/pascalCase}} implements {{#pascalCase}}{{name}} Repository {{/pascalCase}} {

  /// Constructor
  {{#pascalCase}}{{name}} RepositoryImpl {{/pascalCase}}(this.http);

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
          message: 'There was an error with {{#pascalCase}}{{name}} RepositoyImpl {{/pascalCase}}',
        ),
      );
    }
  }
}
