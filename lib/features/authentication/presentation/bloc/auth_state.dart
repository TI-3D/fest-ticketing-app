part of 'auth_bloc.dart';

sealed class AuthState {
const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
final UserEntity user;
const AuthSuccess(this.user);
}

final class AuthRegisteredUncompleted extends AuthState {
  final UserEntity user;

  AuthRegisteredUncompleted(this.user);
}

class AuthRegisteredSuccess extends AuthState {
final String hash;
final String email;

const AuthRegisteredSuccess(this.hash, this.email);
}

final class AuthFailure extends AuthState {
final String message;
const AuthFailure(this.message);
}

class AuthVerificationSuccess extends AuthState {
final String message;

AuthVerificationSuccess({required this.message});
}

class AuthVerificationFailure extends AuthState {
  final String message;

  AuthVerificationFailure(this.message);
}


class AuthOtpResentSuccess extends AuthState {
  final String message = 'OTP resent successfully!';
  final String hash;

  AuthOtpResentSuccess(this.hash);
}


class AuthOtpResentFailure extends AuthState {
  final String message ;

  AuthOtpResentFailure(this.message);
}