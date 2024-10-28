import 'package:flutter/material.dart';

class OrdersDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrdersDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order #${order['orderId']}"),
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
            const Text(
              "Order Items",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Changed to white
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.black, // Changed card color to black
              child: ListTile(
                leading: const Icon(Icons.receipt_long,
                    color: Colors.white), // Changed icon color to white
                title: Text(
                  "${order['itemsCount']} items",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14), // Changed text color to white
                ),
                trailing: const Text(
                  "View All",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Booking details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Changed to white
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.black, // Changed card color to black
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "TXT World Tour Act: Promise in Jakarta",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Changed text color to white
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "10 - 14 - 2024",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70, // Changed to a lighter grey
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
