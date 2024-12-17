import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/authentication/domain/repository/authentication_repository.dart';

class VerificationCodeUseCase extends UseCase<Either, VerificationCodeRequestParams> {
  final AuthenticationRepository repository;

  VerificationCodeUseCase({
    required this.repository,
  });
  @override
  Future<Either> call(VerificationCodeRequestParams params) async {
    return await repository.verificationCode(params);
  }
}

class VerificationCodeRequestParams {
  final String email;
  final String hash;
  final String otp;

  VerificationCodeRequestParams({
    required this.email,
    required this.hash,
    required this.otp,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'hash': hash,
      'otp': otp,
    };
  }
}
