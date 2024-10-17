import 'package:fest_ticketing/core/config/themes/widgets/appbar_theme.dart';
import 'package:fest_ticketing/core/config/themes/widgets/bottomsheet_theme.dart';
import 'package:fest_ticketing/core/config/themes/widgets/checkbox_theme.dart';
import 'package:fest_ticketing/core/config/themes/widgets/chip_theme.dart';
import 'package:fest_ticketing/core/config/themes/widgets/elevated_button_theme.dart';
import 'package:fest_ticketing/core/config/themes/widgets/input_decoration_theme.dart';
import 'package:fest_ticketing/core/config/themes/widgets/snackbar_theme.dart';
import 'package:fest_ticketing/core/config/themes/widgets/text_theme.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'CircularStd',
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    snackBarTheme: AppSnackbarTheme.lightSnackBarTheme,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppColor.bgLight1,
    appBarTheme: AppbarTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: AppInputDecorationTheme.lightInputDecorationTheme,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'CircularStd',
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    snackBarTheme: AppSnackbarTheme.darkSnackBarTheme,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColor.bgDark1,
    appBarTheme: AppbarTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: AppInputDecorationTheme.darkInputDecorationTheme,
  );
}
