import 'package:flutter/material.dart';

class OrdersDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrdersDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order ${order['orderId']}"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${order['itemsCount']} items"),
                TextButton(
                  onPressed: () {
                    // Action for "View All" button
                  },
                  child: const Text("View All", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Booking details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("TXT World Tour Act: Promise in Jakarta"),
            const Text("10 - 14 - 2024"),
          ],
        ),
      ),
    );
  }
}
