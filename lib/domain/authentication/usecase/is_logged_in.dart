import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/domain/authentication/repository/authentication.dart';
import 'package:fest_ticketing/service_locator.dart';

class CurrentUserUseCase extends UseCaseNoParams<bool> {
  @override
  Future<bool> call() async {
    return await sl<AuthenticationRepository>().isLoggedIn();
  }
}