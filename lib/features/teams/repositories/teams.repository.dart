// ignore_for_file: one_member_abstracts
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/features/teams/entities/contact.model.dart';
import 'package:team_aid/main.dart';

/// The provider of TeamsRepository
final teamsProvider = Provider<TeamsRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return TeamsRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class TeamsRepository {
  /// Get data
  Future<Either<Failure, List<ContactModel>>> getContactList({
    required String teamId,
  });
}

/// This class is responsible for implementing the TeamsRepository
class TeamsRepositoryImpl implements TeamsRepository {
  /// Constructor
  TeamsRepositoryImpl(this.http, this.secureStorage);

  /// The http client
  final Client http;

  /// The secure storage
  final FlutterSecureStorage secureStorage;

  /// Get data from backend
  @override
  Future<Either<Failure, List<ContactModel>>> getContactList({
    required String teamId,
  }) async {
    final list = <ContactModel>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/teams/contact-list/$teamId',
      );
      final res = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error retrieving the contact list',
          ),
        );
      }

      final data = (jsonDecode(res.body) as Map)['data'] as List;

      for (final element in data) {
        final contact = ContactModel.fromMap(element as Map<String, dynamic>);
        list.add(contact);
      }

      return Right(list);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en TeamsRepositoyImpl',
        ),
      );
    }
  }
}
