import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideBack;
  final double? height;
  const BasicAppbar(
      {this.title,
      this.hideBack = false,
      this.action,
      this.backgroundColor,
      this.height,
      super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: height ?? AppSize.appBarHeight,
        title: title ?? const Text(''),
        titleSpacing: 0,
        actions: [action ?? Container()],
        leading: hideBack
            ? null
            : IconButton(
                onPressed: () {
                  AppNavigator.pop(context);
                },
                icon: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColor.grey.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Icon(Iconsax.arrow_left_2,
                      size: 16,
                      color: isDark ? AppColor.white : AppColor.black),
                ),
              ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 80);
}
