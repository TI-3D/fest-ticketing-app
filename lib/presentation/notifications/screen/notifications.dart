import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> userNotifications = [
    {
      "message": "Anang, you placed an order, check your order history for full details",
      "read": "false"
    },
    {
      "message": "Anang, Thank you for booking with us. We have canceled order #24568.",
      "read": "true"
    },
    {
      "message": "Anang, your Order #24568 has been confirmed, check your order history...",
      "read": "true"
    },
  ];

  final List<Map<String, String>> organizerNotifications = [
    {
      "message": "Event #24568 has been successfully created.",
      "read": "true"
    },
    {
      "message": "Your event registration is under review.",
      "read": "false"
    },
    {
      "message": "Your payment for Event #24568 has been confirmed.",
      "read": "true"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.red,
          indicatorWeight: 3,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(text: "User"),
            Tab(text: "Event Organizer"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildNotificationList(userNotifications),
            _buildNotificationList(organizerNotifications),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(List<Map<String, String>> notifications) {
    return ListView.builder(
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
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String message;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.message,
    required this.isRead,
    this.onTap,
  });

  String _truncateMessage(String message, int maxWords) {
    List<String> words = message.split(' ');
    if (words.length > maxWords) {
      return '${words.take(maxWords).join(' ')}...';
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
                color: isRead ? Colors.grey : Colors.red,
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

class NotificationDetailPage extends StatelessWidget {
  final String message;

  const NotificationDetailPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
