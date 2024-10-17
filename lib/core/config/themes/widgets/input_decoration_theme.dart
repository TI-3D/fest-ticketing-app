import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';
import 'package:flutter/material.dart';

class AppInputDecorationTheme {
  AppInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColor.grey.withOpacity(0.1),
    errorMaxLines: 3,
    prefixIconColor: AppColor.grey,
    suffixIconColor: AppColor.grey,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    // constraints: const BoxConstraints.expand(height: AppSize.inputFieldHeight),
    // labelStyle: const TextStyle()
    //     .copyWith(fontSize: AppSize.fontSizeMd, color: AppColor.black),
    hintStyle: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeSm,
        color: AppColor.grey,
        fontWeight: FontWeight.w400),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    // floatingLabelStyle:
    //     const TextStyle().copyWith(color: AppColor.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: BorderSide.none),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: BorderSide.none),
    // focusedBorder: const OutlineInputBorder().copyWith(
    //   borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
    //   borderSide: const BorderSide(width: 1, color: AppColor.primary),
    // ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide:
          const BorderSide(width: 1, color: Color.fromRGBO(237, 171, 0, 1)),
    ),
    // focusedErrorBorder: const OutlineInputBorder().copyWith(
    //   borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
    //   borderSide: const BorderSide(width: 2, color: AppColor.warning),
    // ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColor.grey.withOpacity(0.1),
    errorMaxLines: 2,
    prefixIconColor: AppColor.grey,
    suffixIconColor: AppColor.grey,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    // constraints: const BoxConstraints.expand(height: AppSize.inputFieldHeight),
    // labelStyle: const TextStyle()
    //     .copyWith(fontSize: AppSize.fontSizeMd, color: AppColor.white),
    hintStyle: const TextStyle().copyWith(
        fontSize: AppSize.fontSizeSm,
        color: AppColor.white,
        fontWeight: FontWeight.w400),
    // floatingLabelStyle:
    //     const TextStyle().copyWith(color: AppColor.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: BorderSide.none),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: BorderSide.none),
    // focusedBorder: const OutlineInputBorder().copyWith(
    //   borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
    //   borderSide: const BorderSide(width: 1, color: AppColor.primary),
    // ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 1, color: AppColor.warning),
    ),
    // focusedErrorBorder: const OutlineInputBorder().copyWith(
    //   borderRadius: BorderRadius.circular(4),
    //   borderSide: const BorderSide(width: 2, color: AppColor.warning),
    // ),
  );
}
