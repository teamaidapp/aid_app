// ignore_for_file: one_member_abstracts
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/features/myAccount/repositories/myAccount.repository.dart';
import 'package:team_aid/features/travels/repositories/travels.repository.dart';

/// The provider of MyAccountService
final myAccountServiceProvider = Provider<MyAccountServiceImpl>((ref) {
  final myAccountRepository = ref.watch(myAccountProvider);
  final travelsRepository = ref.watch(travelsProvider);
  return MyAccountServiceImpl(myAccountRepository, travelsRepository);
});

/// This class is responsible of the abstraction
abstract class MyAccountService {
  /// Get data
  Future<Either<Failure, Success>> getData();

  /// Update user data
  Future<Either<Failure, Success>> updateUserData({
    required UserModel user,
    required String uid,
  });

  /// Upload a file
  Future<Either<Failure, Success>> uploadFile({required File file});

  /// Patch a file
  Future<Either<Failure, Success>> patchFile({
    required String fileId,
    required String description,
    required List<Guest> guests,
  });
}

/// This class is responsible for implementing the MyAccountService
class MyAccountServiceImpl implements MyAccountService {
  /// Constructor
  MyAccountServiceImpl(this.myAccountRepository, this.travelsRepository);

  /// The myAccount Repository that is injected
  final MyAccountRepository myAccountRepository;

  /// The travels Repository that is injected
  final TravelsRepository travelsRepository;

  @override
  Future<Either<Failure, Success>> getData() async {
    try {
      final result = await myAccountRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with MyAccountServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> updateUserData({
    required UserModel user,
    required String uid,
  }) async {
    try {
      final result = await myAccountRepository.updateUserData(
        user: user,
        uid: uid,
      );

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'Hubo un problema al actualizar los datos de MyAccountServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> uploadFile({
    required File file,
  }) async {
    try {
      final result = await travelsRepository.uploadFile(file: file);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TravelsServiceImpl',
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
      final result = await travelsRepository.patchFile(
        fileId: fileId,
        description: description,
        guests: guests,
      );

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with TravelsServiceImpl',
        ),
      );
    }
  }
}
