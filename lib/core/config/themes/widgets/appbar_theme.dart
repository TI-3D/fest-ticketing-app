import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';
import 'package:flutter/material.dart';


class AppbarTheme{
  AppbarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColor.black, size: AppSize.iconMd),
    actionsIconTheme: IconThemeData(color: AppColor.black, size: AppSize.iconMd),
    titleTextStyle: TextStyle(fontSize: AppSize.fontSizeLg, fontWeight: FontWeight.w600, color: AppColor.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColor.black, size: AppSize.iconMd),
    actionsIconTheme: IconThemeData(color: AppColor.white, size: AppSize.iconMd),
    titleTextStyle: TextStyle(fontSize: AppSize.fontSizeLg, fontWeight: FontWeight.w600, color: AppColor.white),
  );
}