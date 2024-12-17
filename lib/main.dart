import 'package:fest_ticketing/common/bloc/app_user/app_user_cubit.dart';
import 'package:fest_ticketing/core/config/themes/app_theme.dart';
import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/bloc/event_creation/event_creation_bloc.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/bloc/event_organizer/event_organizer_bloc.dart';
import 'package:fest_ticketing/features/home/presentation/bloc/categories/categories_cubit.dart';
import 'package:fest_ticketing/features/home/presentation/bloc/event/event_cubit.dart';
import 'package:fest_ticketing/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:fest_ticketing/firebase_options.dart';
import 'package:fest_ticketing/presentation/splash/screen/splash.dart';
import 'package:fest_ticketing/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<EventCreationBloc>()),
        BlocProvider(create: (context) => sl<EditProfileBloc>()),
        BlocProvider(create: (context) => sl<AppUserCubit>()),
        BlocProvider(create: (context) => sl<CategoriesCubit>()),
        BlocProvider(create: (context) => sl<EventCubit>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<MainMenuBloc>()),
        BlocProvider(create: (context) => sl<EventOrganizerBloc>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          // darkTheme: AppTheme.dark,
          // themeMode: ThemeMode.system,
          home: SplashScreen()),
    );
  }
}
