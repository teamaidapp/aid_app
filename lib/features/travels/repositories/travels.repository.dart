import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as multi_http;
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/travels/entities/travel.model.dart';
import 'package:team_aid/features/travels/entities/travel_api.model.dart';
import 'package:team_aid/main.dart';

/// The provider of TravelsRepository
final travelsProvider = Provider<TravelsRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return TravelsRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class TravelsRepository {
  /// Get the travels
  Future<Either<Failure, List<TravelAPIModel>>> getTravels();

  /// Upload a file
  Future<Either<Failure, Success>> uploadFile({required File file});

  /// Patch a file
  Future<Either<Failure, Success>> patchFile({
    required String fileId,
    required String description,
    required List<Guest> guests,
  });

  /// Create travel
  Future<Either<Failure, Success>> createTravel({required TravelModel travel});
}

/// This class is responsible for implementing the TravelsRepository
class TravelsRepositoryImpl implements TravelsRepository {
  /// Constructor
  TravelsRepositoryImpl(this.http, this.secureStorage);

  /// The http client
  final Client http;

  /// The secure storage
  final FlutterSecureStorage secureStorage;

  @override
  Future<Either<Failure, Success>> uploadFile({
    required File file,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/file',
      );
      final request = multi_http.MultipartRequest('POST', url);

      final headers = <String, String>{'Authorization': 'Bearer $token', 'Content-type': 'multipart/form-data'};
      request.files.add(
        multi_http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );
      request.headers.addAll(headers);

      final res = await request.send();
      // final res = await multipartRequest(
      //   url,
      //   headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      // );
      // multipartRequest.headers['Authorization'] = 'Bearer $token';
      // multipartRequest.headers['Content-Type'] = 'multipart/form-data';
      // multipartRequest.fields['file'] = 'value1';
      // multipartRequest.files.add(await MultipartFile.fromPath('file', file.path));

      // final res = await http.send(multipartRequest);

      // multipartRequest.finalize();

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while uploading the file',
          ),
        );
      }

      final response = await multi_http.Response.fromStream(res);

      final data = (jsonDecode(response.body) as Map<String, dynamic>)['data'] as Map<String, dynamic>;

      return Right(Success(ok: true, message: data['id'] as String));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CalendarRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> patchFile({
    required String fileId,
    required String description,
    required List<Guest> guests,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/file',
      );
      final res = await http.patch(
        url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: jsonEncode({
          'fileId': fileId,
          'description': description,
          'guest': guests.map((e) => e.toMap()).toList(),
        }),
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while uploading the file',
          ),
        );
      }

      final data = (jsonDecode(res.body) as Map<String, dynamic>)['data'] as Map<String, dynamic>;
      return Right(Success(ok: true, message: data['fileKey'] as String));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CalendarRepositoryImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> createTravel({
    required TravelModel travel,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/itinerary',
      );
      final res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: jsonEncode(travel.toMap()),
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while creating the travel',
          ),
        );
      }

      final data = (jsonDecode(res.body) as Map<String, dynamic>)['data'] as Map<String, dynamic>;
      return Right(Success(ok: true, message: data['id'] as String));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CalendarRepositoryImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TravelAPIModel>>> getTravels() async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/itinerary',
      );
      final res = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      );
      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error while getting the travels',
          ),
        );
      }

      final data = (jsonDecode(res.body) as Map<String, dynamic>)['data'] as List<dynamic>;
      final travels = data.map((e) => TravelAPIModel.fromMap(e as Map<String, dynamic>)).toList();
      return Right(travels);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CalendarRepositoryImpl',
        ),
      );
    }
  }
}
