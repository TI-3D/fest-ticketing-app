import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/common/enitites/user.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/resend_code.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signin.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signup.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/verification_code.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Map<String, dynamic>>> signup(SignupRequestParams params);
  Future<Either<Failure, UserEntity>> signIn(SignInRequestParams params);
  Future<Either<Failure, String>> signOut();
  Future<Either<Failure, UserEntity>> currentUser();
  Future<Either<Failure, Map<String, dynamic>>> resendVerificationCode(ResendVerificationCodeRequestParams params);
  Future<Either<Failure, UserEntity>> verificationCode(VerificationCodeRequestParams params);
}
