import 'package:flutter/material.dart';

class FailedSnackBar extends SnackBar {
  final String message;

  FailedSnackBar({Key? key, required this.message}) : super(
    content: Row(
      children: [
        const Icon(Icons.error_outline, color: Colors.white),
        const SizedBox(width: 8),
        Text(message),
      ],
    ),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}