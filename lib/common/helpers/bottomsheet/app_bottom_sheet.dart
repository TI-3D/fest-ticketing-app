import 'package:fest_ticketing/core/constant/size.dart';
import 'package:flutter/material.dart';

class AppBottomSheet {
  static Future<void> display(BuildContext context, Widget child) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.cardRadiusXl),
          topRight: Radius.circular(AppSize.cardRadiusXl),
        ),
      ),
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
