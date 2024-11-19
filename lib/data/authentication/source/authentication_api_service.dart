import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:fest_ticketing/core/network/dio_client.dart';
import 'package:fest_ticketing/data/authentication/models/request/signin_request_params.dart';
import 'package:fest_ticketing/data/authentication/models/request/signup_request_params.dart';
import 'package:fest_ticketing/service_locator.dart';

abstract class AuthenticationApiService {
  Future<Either> signup(SignupRequestParams params);
  Future<Either> signin(SigninRequestParams params);
  Future<Either> signout();
  Future<Either> currentUser();
}

class AuthenticationApiServiceImpl implements AuthenticationApiService {
  @override
  Future<Either> signup(SignupRequestParams params) async {
    try {
      final response =
          await sl<DioClient>().post(ApiUrl.signup, data: params.toMap());

      if (response.statusCode == 200) {
        return Right(response); // Successful signup
      } else {
        return Left(response.data['message']); // Handle errors
      }
    } on DioException catch (e) {
      // print(e);
      return Left(e.response!.data['message']); // Handle exceptions
    }
  }

  @override
  Future<Either> signin(SigninRequestParams params) async {
    try {
      final response =
          await sl<DioClient>().post(ApiUrl.signin, data: params.toMap());

      if (response.statusCode == 200) {
        return Right(response); // Successful signin
      } else {
        return Left(response.data['message']); // Handle errors
      }
    } on DioException catch (e) {
      return Left(e.response!.data['message']); // Handle exceptions
    }
  }

  @override
  Future<Either> signout() async {
    try {
      final response = await sl<DioClient>().post(ApiUrl.signout);

      if (response.statusCode == 200) {
        return Right(response.data); // Successful signout
      } else {
        return Left(response.data['message']); // Handle errors
      }
    } on DioException catch (e) {
      return Left(e.response!.data['message']); // Handle exceptions
    }
  }

  @override
  Future<Either> currentUser() async {
    try {
      final Response response = await sl<DioClient>().get(ApiUrl.currentUser);

      if (response.statusCode == 200) {
        return Right(response); // Successful signout
      } else {
        return Left(response.data['message']); // Handle errors
      }
    } on DioException catch (e) {
      return Left(e.response!.data['message']); // Handle exceptions
    }
  }
}
