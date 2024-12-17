import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/common/enitites/user.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/core/errors/server.dart';
import 'package:fest_ticketing/features/authentication/data/models/user.dart';
import 'package:fest_ticketing/features/authentication/domain/repository/authentication_repository.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/resend_code.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signin.dart';
import 'package:fest_ticketing/features/authentication/data/source/authentication_api_service.dart';
import 'package:fest_ticketing/core/network/connection_checker.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signup.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/verification_code.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApiService remoteDataSource;
  final SecureStorageService localDataSource;
  final ConnectionChecker connectionChecker;

  const AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> signup(
      SignupRequestParams params) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection.'));
      }

      final response = await remoteDataSource.signup(params);
      return response.fold(
        (error) => Left(Failure(error.message)), // Handle server exception
        (responseData) {
          return Right(responseData.data['data'] as Map<String, dynamic>);
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message)); // Handle any server-related errors
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(SignInRequestParams params) async {
    return _handleAuthRequest(
      () async => await remoteDataSource.signin(params),
    );
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      final result = await remoteDataSource.signout();
      return result.fold(
        (error) => Left(Failure(error.message)),
        (response) async {
          // Assuming the response contains a message
          await localDataSource.remove('access_token');
          return Right(
              response.data['message'] ?? 'Successfully signed out' as String);
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message)); // Handle server error
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    return _handleAuthRequest(
      () async => await remoteDataSource.currentUser(),
      saveToken: false,
    );
  }

  // Helper function to handle common authentication request logic
  Future<Either<Failure, UserEntity>> _handleAuthRequest(
      Future<Either<ServerException, Response>> Function() apiCall,
      {bool saveToken = true}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection.'));
      }

      final response = await apiCall();
      return response.fold(
        (error) => Left(Failure(error.message)), // Handle server exception
        (responseData) {
          // Save the access token to local storage
          if (saveToken) {
            localDataSource.write('access_token',
                responseData.data['token']['access_token']['token']);
          }
          if (responseData.statusCode == 200) {
            return Right(User.fromMap(responseData.data['data']['user'])
                .toEntity() as UserEntity);
          } else {
            return Left(Failure('Error: ${responseData.data['message']}'));
          }
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message)); // Handle any server-related errors
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verificationCode(
      VerificationCodeRequestParams params) async {
    return _handleAuthRequest(
        () async => await remoteDataSource.verificationCode(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> resendVerificationCode(
      ResendVerificationCodeRequestParams params) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection.'));
      }

      final response = await remoteDataSource.resendVerificationCode(params);
      return response.fold(
        (error) => Left(Failure(error.message)), // Handle server exception
        (responseData) {
          // Assume that the response contains a message
          if (responseData.statusCode == 200) {
            return Right(responseData.data['data'] as Map<String, dynamic>);
          } else {
            return Left(Failure('Error: ${responseData.data['message']}'));
          }
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message)); // Handle any server-related errors
    }
  }
}
