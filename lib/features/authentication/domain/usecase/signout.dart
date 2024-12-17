import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/authentication/domain/repository/authentication_repository.dart';

class SignoutUseCase extends UseCaseNoParams<Either> {
  final AuthenticationRepository repository;

  SignoutUseCase({required this.repository});
  @override
  Future<Either> call() async {
    return await repository.signOut();
  }
}
