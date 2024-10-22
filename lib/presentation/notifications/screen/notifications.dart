import 'package:flutter/material.dart';
import 'package:fest_ticketing/presentation/notifications/screen/notification_detail_page.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "message":
          "Anang, you placed an order, check your order history for full details",
      "read": "false"
    },
    {
      "message":
          "Anang, Thank you for booking with us. We have canceled order #24568.",
      "read": "true"
    },
    {
      "message":
          "Anang, your Order #24568 has been confirmed, check your order history...",
      "read": "true"
    },
  ];

  NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(
            message: notifications[index]['message']!,
            isRead: notifications[index]['read'] == 'true',
            onTap: () {
              // Navigasi ke halaman detail notifikasi
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationDetailPage(
                    message: notifications[index]['message']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String message;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationCard(
      {Key? key, required this.message, required this.isRead, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Stack(
          alignment: Alignment.topRight,
          children: [
            const Icon(
              Icons.notifications_none,
              size: 30,
              color: Colors.black,
            ),
            if (!isRead)
              const Positioned(
                right: 0,
                top: 0,
                child: Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 10,
                ),
              ),
          ],
        ),
        title: Text(
          message,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        dense: true,
        onTap: onTap,
      ),
    );
  }
}
