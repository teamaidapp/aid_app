// ignore_for_file: one_member_abstracts
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/travels/entities/travel.model.dart';
import 'package:team_aid/features/travels/entities/travel_api.model.dart';
import 'package:team_aid/features/travels/repositories/travels.repository.dart';

/// The provider of TravelsService
final travelsServiceProvider = Provider<TravelsServiceImpl>((ref) {
  final travelsRepository = ref.watch(travelsProvider);
  return TravelsServiceImpl(travelsRepository);
});

/// This class is responsible of the abstraction
abstract class TravelsService {
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

/// This class is responsible for implementing the TravelsService
class TravelsServiceImpl implements TravelsService {
  /// Constructor
  TravelsServiceImpl(this.travelsRepository);

  /// The travels Repository that is injected
  final TravelsRepository travelsRepository;

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

  @override
  Future<Either<Failure, Success>> createTravel({required TravelModel travel}) async {
    try {
      final result = await travelsRepository.createTravel(travel: travel);

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
  Future<Either<Failure, List<TravelAPIModel>>> getTravels() async {
    try {
      final result = await travelsRepository.getTravels();

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
