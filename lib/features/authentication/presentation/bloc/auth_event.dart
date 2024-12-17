part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final SignupRequestParams params;

  AuthSignUp(this.params);
}

class AuthVerificationCodeEvent extends AuthEvent {
  final VerificationCodeRequestParams params;

  AuthVerificationCodeEvent(this.params);
}

final class AuthResendVerificationCodeEvent extends AuthEvent {
  final String email;

  AuthResendVerificationCodeEvent({required this.email});
}

final class AuthSignIn extends AuthEvent {
  final SignInRequestParams params;
  
  AuthSignIn(this.params);
}

final class AuthRegisteredCompleted extends AuthEvent {}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthSignOut extends AuthEvent {}
