import 'package:fest_ticketing/data/authentication/models/request/signin_request_params.dart';

abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final SigninRequestParams params;

  SignUpEvent(this.params);  
}

class SignOutEvent extends AuthEvent {}

class CheckAuthenticationStatus extends AuthEvent {}
