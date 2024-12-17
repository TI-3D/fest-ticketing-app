import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:fest_ticketing/core/errors/server.dart';
import 'package:fest_ticketing/core/network/dio_client.dart';
import 'package:fest_ticketing/features/profile/domain/usecase/update_user_profile.dart';

abstract class ProfileApiService {
  Future<Either<ServerException, Response>> updateProfile(
      UpdateProfileRequestParams profile);
}

class ProfileApiServiceImpl implements ProfileApiService {
  final DioClient _dioClient;

  ProfileApiServiceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<Either<ServerException, Response>> updateProfile(
      UpdateProfileRequestParams profile) async {
    try {
      final FormData formData = await profile.toFormData();

      final response = await _dioClient.patch(
        ApiUrl.updateProfile,
        data: formData,
      );

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(ServerException(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(
          ServerException(e.response?.data['message'] ?? 'Unknown error'));
    }
  }
}
