import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/authentication/domain/repository/authentication_repository.dart';

class ResendVerificationCodeUseCase extends UseCase<Either, ResendVerificationCodeRequestParams> {
  final AuthenticationRepository repository;

  ResendVerificationCodeUseCase({
    required this.repository,
  });
  @override
  Future<Either> call(ResendVerificationCodeRequestParams params) async {
    return await repository.resendVerificationCode(params);
  }
}

class ResendVerificationCodeRequestParams {
  final String email;

  ResendVerificationCodeRequestParams({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}
