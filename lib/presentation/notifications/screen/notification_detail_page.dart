import 'package:flutter/material.dart';

class NotificationDetailPage extends StatelessWidget {
  final String message;

  const NotificationDetailPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details"),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
