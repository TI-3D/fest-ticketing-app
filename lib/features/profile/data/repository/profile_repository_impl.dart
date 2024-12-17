import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/common/enitites/user.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/core/errors/server.dart';
import 'package:fest_ticketing/core/network/connection_checker.dart';
import 'package:fest_ticketing/features/authentication/data/models/user.dart';
import 'package:fest_ticketing/features/profile/data/source/profile_api_service.dart';
import 'package:fest_ticketing/features/profile/domain/repository/profile_repository.dart';
import 'package:fest_ticketing/features/profile/domain/usecase/update_user_profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ConnectionChecker connectionChecker;
  final ProfileApiService profileApiService;

  const ProfileRepositoryImpl({
    required this.connectionChecker,
    required this.profileApiService,
  });

  @override
  Future<Either<Failure, UserEntity>> updateProfile(
      UpdateProfileRequestParams profile) async {
    try {
      // if (!await connectionChecker.isConnected) {
      //   return Left(Failure('No internet connection.'));
      // }

      final response = await profileApiService.updateProfile(profile);
      return response.fold(
        (error) => Left(Failure(error.message)), // Handle server exception
        (responseData) {
          return Right(
              User.fromMap(responseData.data['data'] as Map<String, dynamic>)
                  .toEntity());
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message)); // Handle any server-related errors
    }
  }
}
