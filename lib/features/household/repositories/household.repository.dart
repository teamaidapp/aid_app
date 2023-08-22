// ignore_for_file: one_member_abstracts
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
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

        final data = (jsonDecode(res.body)['data']["pending"] as List<dynamic>);

        for (final element in data) {
          final invitation = HouseholdModel.fromMap(element as Map<String, dynamic>);
          houseHoldList.add(invitation);
        }
        return Right(houseHoldList);
      } catch (e) {
        return Left(
          Failure(
            message: 'Hubo un error en HomeRepositoryImpl',
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en HouseholdRepositoyImpl',
        ),
      );
    }
  }
}
