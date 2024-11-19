import 'package:fest_ticketing/core/constant/color.dart';
import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height, width;
  final bool isLoading;

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, height ?? 60),
        backgroundColor: isLoading ? AppColor.grey : AppColor.primary,
      ),
      child: isLoading
          ? SizedBox(
              height: height ?? 24,
              width: height ?? 24,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                ),
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
            ),
    );
  }
}
