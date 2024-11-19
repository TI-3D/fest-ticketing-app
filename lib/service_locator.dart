import 'package:fest_ticketing/common/bloc/authentication/authentication_bloc.dart';
import 'package:fest_ticketing/core/network/dio_client.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/data/authentication/repository/authentication.dart';
import 'package:fest_ticketing/data/authentication/source/authentication_api_service.dart';
import 'package:fest_ticketing/domain/authentication/repository/authentication.dart';
import 'package:fest_ticketing/domain/authentication/usecase/current_user.dart';
import 'package:fest_ticketing/domain/authentication/usecase/signin.dart';
import 'package:fest_ticketing/domain/authentication/usecase/signout.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<SecureStorageService>(SecureStorageService());
  sl.registerSingleton<DioClient>(DioClient());

  // Authentication
  // Service
  sl.registerSingleton<AuthenticationApiService>(
      AuthenticationApiServiceImpl());
  // Repository
  sl.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl());
  // Use Case
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<SignoutUseCase>(SignoutUseCase());
  sl.registerSingleton<CurrentUserUseCase>(CurrentUserUseCase());

  sl.registerSingleton<AuthBloc>(AuthBloc());
}
