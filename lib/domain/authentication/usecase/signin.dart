import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/data/authentication/models/request/signin_request_params.dart';
import 'package:fest_ticketing/domain/authentication/repository/authentication.dart';
import 'package:fest_ticketing/service_locator.dart';

class SigninUseCase extends UseCase<Either, SigninRequestParams> {
  @override
  Future<Either> call({SigninRequestParams? params}) async {
    return await sl<AuthenticationRepository>().signin(params!);
  }
}