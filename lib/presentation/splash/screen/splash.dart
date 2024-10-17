import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/main_menu/screen/main_menu.dart';
import 'package:fest_ticketing/presentation/splash/bloc/splash_cubit.dart';
import 'package:fest_ticketing/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is Authenticated) {
            AppNavigator.pushReplacement(context, const MainMenuScreen());
          }

          if (state is Unauthenticated) {
            AppNavigator.pushReplacement(context, const MainMenuScreen());
          }
        },
        child: Scaffold(
          backgroundColor: AppColor.primary,
          body: Center(child: Image.asset('assets/images/logo.png')),
        ));
  }
}
