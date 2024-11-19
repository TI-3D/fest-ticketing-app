import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/data/authentication/models/request/signin_request_params.dart';
import 'package:fest_ticketing/data/authentication/models/request/signup_request_params.dart';

abstract class AuthenticationRepository {
  Future<Either> signup (SignupRequestParams params);
  Future<Either> signin(SigninRequestParams params);
  Future<Either> signout();
  Future<Either> currentUser();
  Future<bool> isLoggedIn();
}