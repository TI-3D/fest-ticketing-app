import 'package:fest_ticketing/core/config/themes/app_theme.dart';
import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/firebase_options.dart';
import 'package:fest_ticketing/presentation/splash/bloc/splash_cubit.dart';
import 'package:fest_ticketing/presentation/splash/screen/splash.dart';
import 'package:fest_ticketing/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: (context) => SplashCubit()..init(),
      providers: [
        BlocProvider(
          create: (context) => SplashCubit()..init(),
        ),
        BlocProvider(create: (context) => MainMenuBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        // darkTheme: AppTheme.dark,
        // themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
