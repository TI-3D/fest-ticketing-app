import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/data/authentication/models/request/signin_request_params.dart';
import 'package:fest_ticketing/data/authentication/models/request/signup_request_params.dart';
import 'package:fest_ticketing/data/authentication/models/user.dart';
import 'package:fest_ticketing/data/authentication/source/authentication_api_service.dart';
import 'package:fest_ticketing/domain/authentication/enities/user.dart';
import 'package:fest_ticketing/domain/authentication/repository/authentication.dart';
import 'package:fest_ticketing/service_locator.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  Future<Either> signup(SignupRequestParams params) {
    throw UnimplementedError();
  }

  // @override
  // Future<Either> signin(SigninRequestParams params) async {
  //   // throw UnimplementedError();
  //   Either result = await sl<AuthenticationApiService>().signin(params);
  //   // print("result: ${result['data']}");
  //   return result.fold((error) {
  //     return Left(error);
  //   }, (data) async {
  //     Response response = data;
  //     await sl<SecureStorageService>().write(
  //         'access_token', response.data['token']['access_token']['token']);
  //     String? token = await sl<SecureStorageService>().read('access_token');
  //     return Right(response.data);
  //   });
  // }

  @override
  Future<Either> signin(SigninRequestParams params) async {
    try {
      final result = await sl<AuthenticationApiService>().signin(params);
      return result.fold((error) {
        return Left(error);
      }, (data) async {
        Response response = data;
        await sl<SecureStorageService>().write(
            'access_token', response.data['token']['access_token']['token']);
        await sl<SecureStorageService>().read('access_token');
        return Right(User.fromMap(response.data['data']['user']).toEntity());
      });
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> signout() async {
    try {
      final result = await sl<AuthenticationApiService>().signout();
      return result.fold((error) {
        return Left(error);
      }, (data) async {
        Response response = data;
        await sl<SecureStorageService>().remove('access_token');
        return Right(response.data['message']);
      });
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> currentUser() async {
    try {
      final result = await sl<AuthenticationApiService>().currentUser();
      return result.fold((error) {
        return Left(error);
      }, (data) async {
        Response response = data;
        final UserEntity user =
            User.fromMap(response.data['data']['user']).toEntity();
        return Right(user);
      });
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await sl<SecureStorageService>().read('access_token');
    return token != null;
  }
}
