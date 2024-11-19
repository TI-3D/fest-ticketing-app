import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/domain/authentication/repository/authentication.dart';
import 'package:fest_ticketing/service_locator.dart';

class CurrentUserUseCase extends UseCaseNoParams<Either> {
  @override
  Future<Either> call() async {
    return await sl<AuthenticationRepository>().currentUser();
  }
}