// notifications.dart
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
          fontSize: 16,
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

  const NotificationCard({
    Key? key,
    required this.message,
    required this.isRead,
    this.onTap,
  }) : super(key: key);

  String _truncateMessage(String message, int maxWords) {
    List<String> words = message.split(' ');
    if (words.length > maxWords) {
      return words.take(maxWords).join(' ') + '...';
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.notifications_none,
                size: 30,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _truncateMessage(message, 10),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (!isRead)
                      const SizedBox(height: 8),
                    if (!isRead)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Unread",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
