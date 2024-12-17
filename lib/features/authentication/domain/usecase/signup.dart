import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/authentication/data/models/user.dart';
import 'package:fest_ticketing/features/authentication/domain/repository/authentication_repository.dart';

class SignUpUseCase extends UseCase<Either, SignupRequestParams> {
  final AuthenticationRepository repository;

  SignUpUseCase({
    required this.repository,
  });
  @override
  Future<Either> call(SignupRequestParams params) async {
    return await repository.signup(params);
  }
}

class SignupRequestParams {
  final String email;
  final String fullName;
  final String password;
  final String passwordConfirmation;
  final Gender gender;

  SignupRequestParams({
    required this.email,
    required this.fullName,
    required this.password,
    required this.passwordConfirmation,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'full_name': fullName,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'gender': gender.displayName,
    };
  }
}
