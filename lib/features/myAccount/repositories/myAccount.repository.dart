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
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/main.dart';

/// The provider of MyAccountRepository
final myAccountProvider = Provider<MyAccountRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return MyAccountRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class MyAccountRepository {
  /// Get data
  Future<Either<Failure, Success>> getData();

  /// Update user data
  Future<Either<Failure, Success>> updateUserData({required UserModel user});
}

/// This class is responsible for implementing the MyAccountRepository
class MyAccountRepositoryImpl implements MyAccountRepository {
  /// Constructor
  MyAccountRepositoryImpl(this.http, this.secureStorage);

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
          message: 'Hubo un error en MyAccountRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> updateUserData({
    required UserModel user,
  }) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/users',
      );

      final data = <String, dynamic>{};

      if (user.cityId.isNotEmpty) {
        data['city'] = user.cityId;
      }

      if (user.firstName.isNotEmpty) {
        data['firstName'] = user.firstName;
      }

      if (user.lastName.isNotEmpty) {
        data['lastName'] = user.lastName;
      }

      if (user.phoneNumber.isNotEmpty) {
        data['phone'] = user.phoneNumber;
      }

      if (user.stateId.isNotEmpty) {
        data['state'] = user.stateId;
      }

      if (user.biography.isNotEmpty) {
        data['biography'] = user.biography;
      }

      if (user.isBiographyVisible != null) {
        data['isBiographyVisible'] = user.isBiographyVisible;
      }

      if (user.isAvatarVisible != null) {
        data['isAvatarVisible'] = user.isAvatarVisible;
      }

      if (user.isEmailVisible != null) {
        data['isEmailVisible'] = user.isEmailVisible;
      }

      if (user.isFatherVisible != null) {
        data['isFatherVisible'] = user.isFatherVisible;
      }

      if (user.isPhoneVisible != null) {
        data['isPhoneVisible'] = user.isPhoneVisible;
      }

      final res = await http.patch(
        url,
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'Hubo un error en MyAccountRepositoyImpl',
          ),
        );
      }

      return Right(Success(ok: true, message: 'Success'));
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un error en MyAccountRepositoyImpl',
        ),
      );
    }
  }
}
