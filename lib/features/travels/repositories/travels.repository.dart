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
import 'package:team_aid/features/travels/entities/hotel.model.dart';
import 'package:team_aid/features/travels/entities/itinerary.model.dart';
import 'package:team_aid/main.dart';

/// The provider of TravelsRepository
final travelsProvider = Provider<TravelsRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return TravelsRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class TravelsRepository {
  /// Get data
  Future<Either<Failure, Success>> getData();

  /// Add itinerary
  Future<Either<Failure, Success>> addItinerary({
    required ItineraryModel itinerary,
  });

  /// Add hotel
  Future<Either<Failure, Success>> addHotel({
    required HotelModel hotel,
  });
}

/// This class is responsible for implementing the TravelsRepository
class TravelsRepositoryImpl implements TravelsRepository {
  /// Constructor
  TravelsRepositoryImpl(this.http, this.secureStorage);

  /// The http client
  final Client http;

  /// The secure storage
  final FlutterSecureStorage secureStorage;

  /// Get data from backend
  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      return Right(Success(ok: true, message: 'Success'));
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en TravelsRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> addHotel({
    required HotelModel hotel,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/hotel',
      );
      final res = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(hotel.toMap()),
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while fetching the data',
          ),
        );
      }
      return Right(Success(ok: true, message: 'Event created'));
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en CalendarRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> addItinerary({
    required ItineraryModel itinerary,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/itinerary',
      );
      final res = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(itinerary.toMap()),
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while fetching the data',
          ),
        );
      }
      return Right(Success(ok: true, message: 'Event created'));
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en CalendarRepositoyImpl',
        ),
      );
    }
  }
}
