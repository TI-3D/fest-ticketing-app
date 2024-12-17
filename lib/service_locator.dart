import 'package:fest_ticketing/common/bloc/app_user/app_user_cubit.dart';
import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/core/network/connection_checker.dart';
import 'package:fest_ticketing/core/network/dio_client.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/features/authentication/data/repository/authentication_impl.dart';
import 'package:fest_ticketing/features/authentication/data/source/authentication_api_service.dart';
import 'package:fest_ticketing/features/authentication/domain/repository/authentication_repository.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/current_user.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/resend_code.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signin.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signout.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/signup.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/verification_code.dart';
import 'package:fest_ticketing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fest_ticketing/features/event_organizer/data/repository/event_organizer_repository_impl.dart';
import 'package:fest_ticketing/features/event_organizer/data/source/event_organizer_api_service.dart';
import 'package:fest_ticketing/features/event_organizer/domain/repository/event_organizer_repository.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/get_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/update_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/bloc/event_creation/event_creation_bloc.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/bloc/event_organizer/event_organizer_bloc.dart';
import 'package:fest_ticketing/features/home/data/repository/event_repository_impl.dart';
import 'package:fest_ticketing/features/home/data/source/event_api_service.dart';
import 'package:fest_ticketing/features/home/domain/repository/event_repository.dart';
import 'package:fest_ticketing/features/home/domain/usecase/get_categories.dart';
import 'package:fest_ticketing/features/home/domain/usecase/get_event.dart';
import 'package:fest_ticketing/features/home/presentation/bloc/categories/categories_cubit.dart';
import 'package:fest_ticketing/features/home/presentation/bloc/event/event_cubit.dart';
import 'package:fest_ticketing/features/profile/data/repository/profile_repository_impl.dart';
import 'package:fest_ticketing/features/profile/data/source/profile_api_service.dart';
import 'package:fest_ticketing/features/profile/domain/repository/profile_repository.dart';
import 'package:fest_ticketing/features/profile/domain/usecase/update_user_profile.dart';
import 'package:fest_ticketing/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  _initAuth();
  _initEvents();
  _initEventOganizer();
  _editProfile();
  sl.registerSingleton<SecureStorageService>(SecureStorageService());
// sl.registerSingleton<CameraService>(CameraService());
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerFactory(() => InternetConnection());

  // core
  sl.registerLazySingleton(
    () => AppUserCubit(),
  );
  sl.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton(() => MainMenuBloc());
}

void _initAuth() {
  sl
    // Data sources
    ..registerFactory<AuthenticationApiService>(
      () => AuthenticationApiServiceImpl(
        dioClient: sl(),
      ),
    )
    // Repositories
    ..registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        connectionChecker: sl(),
      ),
    )
    // Use cases
    ..registerFactory<SignUpUseCase>(
      () => SignUpUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<SignInUseCase>(
      () => SignInUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<ResendVerificationCodeUseCase>(
      () => ResendVerificationCodeUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<VerificationCodeUseCase>(
      () => VerificationCodeUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<SignoutUseCase>(
      () => SignoutUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<CurrentUserUseCase>(
      () => CurrentUserUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory(() => AuthBloc(
          userSignUp: sl(),
          userSigIn: sl(),
          currentUser: sl(),
          verificationCodeUseCase: sl(),
          resendVerificationCodeUseCase: sl(),
          appUserCubit: sl(),
          signoutUseCase: sl(),
        ));
}

void _initEvents() {
  sl
    // Data sources
    ..registerFactory<EventApiService>(
      () => EventApiServiceImpl(
        dioClient: sl(),
      ),
    )
    // Repositories
    ..registerFactory<EventRepository>(
      () => EventRepositoryImpl(
        localDataSource: sl(),
        connectionChecker: sl(),
        remoteDataSource: sl(),
      ),
    )
    // Use cases
    ..registerFactory<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<GetEventUseCase>(
      () => GetEventUseCase(
        repository: sl(),
      ),
    )

    // Cubits
    ..registerFactory<EventCubit>(() => EventCubit(
          eventUseCase: sl(),
        ))
    ..registerFactory<CategoriesCubit>(() => CategoriesCubit(
          categoriesUseCase: sl(),
        ));
}

void _initEventOganizer() {
  sl
    // Data sources
    ..registerFactory<EventOrganizerApiService>(
      () => EventOrganizerApiServiceImpl(
        dioClient: sl(),
      ),
    )
    // Repositories
    ..registerFactory<EventOrganizerRepository>(
      () => EventOrganizerRepositoryImpl(
        remoteDataSource: sl(),
        connectionChecker: sl(),
      ),
    )
    // Use cases
    ..registerFactory<CreateEventOrganizerUseCase>(
      () => CreateEventOrganizerUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<GetEventOrganizerUseCase>(
      () => GetEventOrganizerUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<UpdateEventOrganizerUseCase>(
      () => UpdateEventOrganizerUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<CreateEventUseCase>(
      () => CreateEventUseCase(
        repository: sl(),
      ),
    )


    // Bloc
    ..registerFactory<EventCreationBloc>(() => EventCreationBloc(
          createEventUseCase: sl(),
        ))
    ..registerFactory<EventOrganizerBloc>(() => EventOrganizerBloc(
          createEventOrganizerUseCase: sl(),
          getEventOrganizerUseCase: sl(),
          updateEventOrganizerUseCase: sl(),
        ));
}

void _editProfile() {
  sl
    // Data sources
    ..registerFactory<ProfileApiService>(
      () => ProfileApiServiceImpl(
        dioClient: sl(),
      ),
    )
    // Repositories
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(
        connectionChecker: sl(),
        profileApiService: sl(),
      ),
    )
    // Use cases

    ..registerFactory<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(
        repository: sl(),
      ),
    )
    ..registerFactory<EditProfileBloc>(() => EditProfileBloc(
          appUserCubit: sl(),
          updateProfileUseCase: sl(),
        ));
  ;
}
