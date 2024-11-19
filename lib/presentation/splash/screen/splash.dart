import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/main_menu/screen/main_menu.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a 2-second delay before navigating to MainMenuScreen
    Future.delayed(const Duration(seconds: 2), () {
      AppNavigator.pushReplacement(context, const MainMenuScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
