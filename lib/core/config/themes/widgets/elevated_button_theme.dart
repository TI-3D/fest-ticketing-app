import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';
import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: const Color.fromRGBO(210, 48, 48, 1),
      // side: const BorderSide(color: AppColor.primary),
      padding: const EdgeInsets.symmetric(vertical: AppSize.buttonHeight),
      textStyle: const TextStyle(
          fontSize: AppSize.fontSizeMd,
          color: AppColor.textWhite,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.buttonRadiusCircular)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColor.primary,
      // side: const BorderSide(color: AppColor.primary),
      padding: const EdgeInsets.symmetric(vertical: AppSize.buttonHeight),
      textStyle: const TextStyle(
          fontSize: AppSize.fontSizeMd,
          color: AppColor.textWhite,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.buttonRadiusCircular)),
    ),
  );
}
