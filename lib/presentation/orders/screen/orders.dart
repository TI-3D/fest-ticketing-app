// orders.dart
import 'package:flutter/material.dart';
import 'orders_detail.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "orderId": "TXT World Tour Act: Promise in Jakarta",
      "date": "10 - 14 - 2024",
      "status": "Pending Payment"
    },
    {
      "orderId": "CITY CAMP 2024",
      "date": "10 - 14 - 2024",
      "status": "Completed"
    },
    {
      "orderId": "TXT World Tour Act: Promise in Jakarta",
      "date": "10 - 14 - 2024",
      "status": "Canceled"
    },
    {
      "orderId": "Day6 : FOREVER YOUNG",
      "date": "10 - 14 - 2024",
      "status": "Canceled"
    },
  ];

  OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return OrderCard(
              orderId: orders[index]['orderId'] ?? "Unknown Order",
              date: orders[index]['date'] ?? "Unknown Date",
              status: orders[index]['status'] ?? "Unknown Status",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OrdersDetailsPage(order: orders[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case "Pending Payment":
        statusColor = Colors.orange;
        break;
      case "Completed":
        statusColor = Colors.green;
        break;
      case "Canceled":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderId,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(117, 117, 117, 1),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
