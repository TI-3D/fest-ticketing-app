import 'package:fest_ticketing/domain/authentication/enities/user.dart';

abstract class AuthState {}

class Unauthenticated extends AuthState {
  String? message;

  Unauthenticated({this.message});
}

class Authenticated extends AuthState {
  final UserEntity user;
  String? message;

  Authenticated({ required this.user, this.message });
}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
