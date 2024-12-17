import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/authentication/domain/repository/authentication_repository.dart';

class SignInUseCase extends UseCase<Either, SignInRequestParams> {
  final AuthenticationRepository repository;

  SignInUseCase({
    required this.repository,
  });
  @override
  Future<Either> call(SignInRequestParams params) async {
    return await repository.signIn(params);
  }
}

class SignInRequestParams {
  final String email;
  final String password;

  SignInRequestParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
