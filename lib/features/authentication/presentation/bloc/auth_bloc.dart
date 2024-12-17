import 'package:fest_ticketing/common/bloc/app_user/app_user_cubit.dart';
import 'package:fest_ticketing/common/enitites/user.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/current_user.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/resend_code.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signin.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signout.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signup.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/verification_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _userSignUp;
  final SignInUseCase _userSigIn;
  final CurrentUserUseCase _currentUser;
  final VerificationCodeUseCase _verificationCodeUseCase;
  final ResendVerificationCodeUseCase _resendVerificationCodeUseCase;
  final AppUserCubit _appUserCubit;
  final SignoutUseCase _signoutUseCase;
  AuthBloc({
    required SignUpUseCase userSignUp,
    required SignInUseCase userSigIn,
    required CurrentUserUseCase currentUser,
    required VerificationCodeUseCase verificationCodeUseCase,
    required ResendVerificationCodeUseCase resendVerificationCodeUseCase,
    required AppUserCubit appUserCubit,
    required SignoutUseCase signoutUseCase,
  })  : _userSignUp = userSignUp,
        _userSigIn = userSigIn,
        _currentUser = currentUser,
        _verificationCodeUseCase = verificationCodeUseCase,
        _resendVerificationCodeUseCase = resendVerificationCodeUseCase,
        _appUserCubit = appUserCubit,
        _signoutUseCase = signoutUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthSignOut>(_onAuthSignOut);
    on<AuthRegisteredCompleted>(_registerCompleted);
    on<AuthVerificationCodeEvent>(_onAuthVerificationCode);
    on<AuthResendVerificationCodeEvent>(_onAuthResendVerificationCode);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _currentUser();

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _signoutUseCase();

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthInitial()),
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _userSignUp(event.params);

    res.fold((failure) => emit(AuthFailure(failure.message)), (r) {
      _emitAuthSignupSuccess(r['hash'], event.params.email, emit);
    });
  }

  void _onAuthVerificationCode(
    AuthVerificationCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _verificationCodeUseCase(event.params);

    res.fold(
      (l) => emit(AuthVerificationFailure(l.message)), // On failure
      (r) => _emitAuthSuccess(r, emit), // On success
    );
  }

  // Handler for resending OTP
  void _onAuthResendVerificationCode(
    AuthResendVerificationCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _resendVerificationCodeUseCase(
      ResendVerificationCodeRequestParams(email: event.email),
    );

    res.fold(
      (l) => emit(AuthOtpResentFailure(l.message)), // On failure
      (r) => emit(AuthOtpResentSuccess(r['hash'])), // On success
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _userSigIn(event.params);

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(
    UserEntity user,
    Emitter<AuthState> emit,
  ) {
    if (user.embedding == null) {
      emit(AuthRegisteredUncompleted(user));
      return;
    }
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _emitAuthSignupSuccess(
    String hash,
    String email,
    Emitter<AuthState> emit,
  ) {
    emit(AuthRegisteredSuccess(hash, email));
  }

  void _registerCompleted(
    AuthRegisteredCompleted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _currentUser();

    res.fold((l) {
      emit(AuthFailure(l.message));
    }, (r) {
      _emitAuthSuccess(r, emit);
    });
  }
}
