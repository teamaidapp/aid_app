// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/{{name}}/repositories/{{name}}.repository.dart';

/// The provider of {{#pascalCase}}{{name}} Service {{/pascalCase}}
final {{#camelCase}}{{name}} ServiceProvider {{/camelCase}} = Provider<{{#pascalCase}}{{name}} ServiceImpl {{/pascalCase}}>((ref) {
  final {{name}}Repository = ref.watch({{#camelCase}}{{name}} Provider {{/camelCase}});
  return {{#pascalCase}}{{name}} ServiceImpl {{/pascalCase}}({{name}}Repository);
});

/// This class is responsible of the abstraction
abstract class {{#pascalCase}}{{name}} Service {{/pascalCase}} {
  /// Get data
  Future<Either<Failure, Success>> getData();
}

/// This class is responsible for implementing the {{#pascalCase}}{{name}} Service {{/pascalCase}}
class {{#pascalCase}}{{name}} ServiceImpl {{/pascalCase}} implements {{#pascalCase}}{{name}} Service {{/pascalCase}} {

  /// Constructor
  {{#pascalCase}}{{name}} ServiceImpl {{/pascalCase}}(this.{{name}}Repository);

  /// The {{name}} Repository that is injected
  final {{#pascalCase}}{{name}} Repository {{/pascalCase}} {{name}}Repository;

  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      final result = await {{name}}Repository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(          
          message: 'Hubo un problema al obtener los datos de {{#pascalCase}}{{name}} ServiceImpl {{/pascalCase}}',
        ),
      );
    }
  }
}
