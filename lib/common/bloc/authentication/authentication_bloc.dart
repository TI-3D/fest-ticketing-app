import 'package:fest_ticketing/data/authentication/models/request/signin_request_params.dart';
import 'package:fest_ticketing/domain/authentication/enities/user.dart';
import 'package:fest_ticketing/domain/authentication/usecase/current_user.dart';
import 'package:fest_ticketing/domain/authentication/usecase/signin.dart';
import 'package:fest_ticketing/domain/authentication/usecase/signout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:fest_ticketing/service_locator.dart';
import 'package:dartz/dartz.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Unauthenticated()) {
    on<SignInEvent>(_onSignIn); // Registering the handler for SignInEvent
    on<SignOutEvent>(_onSignOut);
    on<CheckAuthenticationStatus>(_onCheckAuthStatus);
  }

  // Event handler for Sign In
  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Show loading state

    final result = await sl<SigninUseCase>().call(
        params:
            SigninRequestParams(email: event.email, password: event.password));
    result.fold(
      (error) {
        emit(AuthError(message: error.toString()));
      },
      (data) async {
        print("data: $data - ${data.runtimeType}");
        emit(Authenticated(user: data)); // Emit Authentreicated state
      },
    );
  }

  // Event handler for Sign Out
  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await sl<SignoutUseCase>().call();

    await result.fold(
      (error) {
        emit(AuthError(message: error.toString()));
      },
      (data) async {
        emit(Unauthenticated(message: "Signed out successfully"));
      },
    );
  }

  // Event handler for checking authentication status (on app start)
  Future<void> _onCheckAuthStatus(
      CheckAuthenticationStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await sl<CurrentUserUseCase>().call();

    await result.fold(
      (error) {
        emit(AuthError(message: error.toString()));
      },
      (data) async {
        final user = data as UserEntity;
        emit(Authenticated(user: user));
      },
    );
  }
}
