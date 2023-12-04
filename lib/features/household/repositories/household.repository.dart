// ignore_for_file: one_member_abstracts
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/household/entities/household.model.dart';
import 'package:team_aid/main.dart';

/// The provider of HouseholdRepository
final householdProvider = Provider<HouseholdRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return HouseholdRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class HouseholdRepository {
  /// Get data
  Future<Either<Failure, List<HouseholdModel>>> getHouseholds();

  /// The `deleteHousehold` method in the `HouseholdRepository` class is responsible for deleting a
  /// household from the backend. It takes a required parameter `id` which is the identifier of the
  /// household to be deleted.
  Future<Either<Failure, Success>> deleteHousehold({required String id});
}

/// This class is responsible for implementing the HouseholdRepository
class HouseholdRepositoryImpl implements HouseholdRepository {
  /// Constructor
  HouseholdRepositoryImpl(this.http, this.secureStorage);

  /// The http client
  final Client http;

  /// The secure storage
  final FlutterSecureStorage secureStorage;

  /// Get data from backend
  @override
  Future<Either<Failure, List<HouseholdModel>>> getHouseholds() async {
    try {
      final houseHoldList = <HouseholdModel>[];
      try {
        final token = await secureStorage.read(key: TAConstants.accessToken);
        final url = Uri.parse(
          '${dotenv.env['API_URL']}/users/sons',
        );
        final res = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        final data = jsonDecode(res.body)['data'] as List<dynamic>;

        for (final element in data) {
          if (element['status'] != 'deleted') {
            final invitation = HouseholdModel.fromMap(element as Map<String, dynamic>);
            houseHoldList.add(invitation);
          }
        }
        return Right(houseHoldList);
      } catch (e) {
        return Left(
          Failure(
            message: 'There was an error with HomeRepositoryImpl',
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with HouseholdRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> deleteHousehold({required String id}) async {
    try {
      try {
        final token = await secureStorage.read(key: TAConstants.accessToken);
        final url = Uri.parse(
          '${dotenv.env['API_URL']}/users/delete-son?id=$id',
        );
        final res = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );

        if (res.statusCode != 200 && res.statusCode != 201) {
          return Left(
            Failure(
              message: 'There was an error deleting the household',
            ),
          );
        }

        return Right(Success(ok: true, message: 'Household deleted successfully'));
      } catch (e) {
        return Left(
          Failure(
            message: 'There was an error deleting the household',
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an unexpected error deleting the household',
        ),
      );
    }
  }
}
