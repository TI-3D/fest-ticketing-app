import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/errors/server.dart';
import 'package:fest_ticketing/core/network/dio_client.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/resend_code.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signin.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signup.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/verification_code.dart';

abstract class AuthenticationApiService {
  Future<Either<ServerException, Response>> signup(SignupRequestParams params);
  Future<Either<ServerException, Response>> signin(SignInRequestParams params);
  Future<Either<ServerException, Response>> signout();
  Future<Either<ServerException, Response>> currentUser();
  Future<Either<ServerException, Response>> verificationCode(
      VerificationCodeRequestParams params);
  Future<Either<ServerException, Response>> resendVerificationCode(
      ResendVerificationCodeRequestParams params);
}

class AuthenticationApiServiceImpl implements AuthenticationApiService {
  final DioClient _dioClient;

  AuthenticationApiServiceImpl({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  @override
  Future<Either<ServerException, Response>> signup(
      SignupRequestParams params) async {
    try {
      final Response response =
          await _dioClient.post(ApiUrl.signup, data: params.toMap());

      if (response.statusCode == 201) {
        return Right(response);
      } else {
        return Left(ServerException(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(
          ServerException(e.response?.data['message'] ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<ServerException, Response>> signin(
      SignInRequestParams params) async {
    try {
      final Response response =
          await _dioClient.post(ApiUrl.signin, data: params.toMap());
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

  @override
  Future<Either<ServerException, Response>> signout() async {
    try {
      final Response response = await _dioClient.delete(ApiUrl.signout);

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

  @override
  Future<Either<ServerException, Response>> currentUser() async {
    try {
      final Response response = await _dioClient.get(ApiUrl.currentUser);

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

  @override
  Future<Either<ServerException, Response>> verificationCode(
      VerificationCodeRequestParams params) async {
    try {
      final Response response =
          await _dioClient.post(ApiUrl.verificationCode, data: params.toMap());

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

  @override
  Future<Either<ServerException, Response>> resendVerificationCode(
      ResendVerificationCodeRequestParams params) async {
    try {
      final Response response = await _dioClient
          .post(ApiUrl.resendVerificationCode, data: params.toMap());

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
