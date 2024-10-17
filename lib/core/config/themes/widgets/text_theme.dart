import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';
import 'package:flutter/material.dart';

/// Custom Class for Light & Dark Text Themes
class AppTextTheme {
  AppTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeXxl,
        fontWeight: FontWeight.bold,
        color: AppColor.bgDark1),
    headlineMedium: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeXl,
        fontWeight: FontWeight.w600,
        color: AppColor.bgDark1),
    headlineSmall: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeLg,
        fontWeight: FontWeight.w600,
        color: AppColor.bgDark1),
    titleLarge: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeMd,
        fontWeight: FontWeight.w600,
        color: AppColor.bgDark1),
    titleMedium: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeMd,
        fontWeight: FontWeight.w500,
        color: AppColor.bgDark1),
    titleSmall: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeMd,
        fontWeight: FontWeight.w400,
        color: AppColor.bgDark1),
    bodyLarge: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeSm,
        fontWeight: FontWeight.w500,
        color: AppColor.bgDark1),
    bodyMedium: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeSm,
        fontWeight: FontWeight.normal,
        color: AppColor.bgDark1),
    bodySmall: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeSm,
        fontWeight: FontWeight.w500,
        color: AppColor.bgDark1.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeXs,
        fontWeight: FontWeight.normal,
        color: AppColor.bgDark1),
    labelMedium: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeXs,
        fontWeight: FontWeight.normal,
        color: AppColor.bgDark1.withOpacity(0.5)),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeXxl,
        fontWeight: FontWeight.bold,
        color: AppColor.bgLight1),
    headlineMedium: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeXl,
        fontWeight: FontWeight.w600,
        color: AppColor.bgLight1),
    headlineSmall: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeLg,
        fontWeight: FontWeight.w600,
        color: AppColor.bgLight1),
    titleLarge: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeMd,
        fontWeight: FontWeight.w600,
        color: AppColor.bgLight1),
    titleMedium: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeMd,
        fontWeight: FontWeight.w500,
        color: AppColor.bgLight1),
    titleSmall: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeMd,
        fontWeight: FontWeight.w400,
        color: AppColor.bgLight1),
    bodyLarge: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeSm,
        fontWeight: FontWeight.w500,
        color: AppColor.bgLight1),
    bodyMedium: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeSm,
        fontWeight: FontWeight.normal,
        color: AppColor.bgLight1),
    bodySmall: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeSm,
        fontWeight: FontWeight.w500,
        color: AppColor.bgLight1.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeXs,
        fontWeight: FontWeight.normal,
        color: AppColor.bgLight1),
    labelMedium: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeXs,
        fontWeight: FontWeight.normal,
        color: AppColor.bgLight1.withOpacity(0.5)),
  );
}
