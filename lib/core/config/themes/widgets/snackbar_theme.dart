import 'package:fest_ticketing/core/constant/color.dart';
import 'package:flutter/material.dart';

class AppSnackbarTheme {
  AppSnackbarTheme._();

  // Light theme Snackbar
  static final lightSnackBarTheme = SnackBarThemeData(
    backgroundColor: AppColor.bgDark1.withOpacity(0.85),
    contentTextStyle: TextStyle(
      color: AppColor.textWhite,
      fontSize: 14,
    ),
    actionTextColor: AppColor.primary,
  );

  // Dark theme Snackbar
  static const darkSnackBarTheme = SnackBarThemeData(
    backgroundColor: AppColor.bgDark2,
    contentTextStyle: TextStyle(
      color: AppColor.textWhite,
      fontSize: 12,
    ),
    actionTextColor: AppColor.primary,
  );
}
