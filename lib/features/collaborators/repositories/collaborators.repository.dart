// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/collaborators/entities/collaborator.model.dart';
import 'package:team_aid/main.dart';

/// The provider of CollaboratorsRepository
final collaboratorsProvider = Provider<CollaboratorsRepository>((ref) {
  final http = ref.watch(httpProvider);
  return CollaboratorsRepositoryImpl(http);
});

/// This class is responsible of the abstraction
abstract class CollaboratorsRepository {
  /// Get data
  Future<Either<Failure, List<CollaboratorModel>>> getData();
}

/// This class is responsible for implementing the CollaboratorsRepository
class CollaboratorsRepositoryImpl implements CollaboratorsRepository {
  /// Constructor
  CollaboratorsRepositoryImpl(this.http);

  /// The http client
  final Client http;

  /// Get data from backend
  @override
  Future<Either<Failure, List<CollaboratorModel>>> getData() async {
    try {
      final collaborators = [
        CollaboratorModel(
          id: '123',
          status: 'active',
          createdAt: '2023-02-02',
          updateAt: '2023-02-02',
          userId: UserId(
            id: '456',
            firstName: 'John',
            lastName: 'Doe',
            email: 'john.doe@example.com',
            isEmailVisible: true,
            phoneNumber: '123-456-7890',
            isPhoneVisible: true,
            role: 'admin',
            accountVerificationState: 'verified',
            isFatherVisible: false,
            avatar: 'https://example.com/avatar.jpg',
            isAvatarVisible: true,
            biography: 'Software engineer with 5 years of experience.',
            isBiographyVisible: true,
            createdAt: '2022-01-01',
          ),
        ),
      ];
      return Right(collaborators);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with CollaboratorsRepositoyImpl',
        ),
      );
    }
  }
}
