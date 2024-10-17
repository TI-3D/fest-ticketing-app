import 'package:fest_ticketing/core/constant/color.dart';
import 'package:flutter/material.dart';

class AppChipTheme {
  AppChipTheme._();

  static ChipThemeData lightChipTheme = const ChipThemeData(
    disabledColor: AppColor.bgLight2,
    labelStyle: TextStyle(color: AppColor.black),
    selectedColor: AppColor.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: AppColor.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: AppColor.bgLight2,
    labelStyle: TextStyle(color: AppColor.white),
    selectedColor: AppColor.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: AppColor.white,
  );
}
