import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/common/enitites/user.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/features/profile/domain/usecase/update_user_profile.dart';

abstract class ProfileRepository {
  // Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, UserEntity>> updateProfile(UpdateProfileRequestParams profile);
}