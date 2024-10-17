import 'package:fest_ticketing/core/constant/color.dart';
import 'package:flutter/material.dart';

class AppSnackbarTheme {
  AppSnackbarTheme._();

  static const lightSnackBarTheme = SnackBarThemeData(
    backgroundColor: AppColor.bgLight1,
    contentTextStyle: TextStyle(
      color: AppColor.black,
      fontSize: 14,
    ),
  );

  static const darkSnackBarTheme = SnackBarThemeData(
    backgroundColor: AppColor.bgDark1,
    contentTextStyle: TextStyle(
      color: AppColor.white,
      fontSize: 14,
    ),
  );
}
