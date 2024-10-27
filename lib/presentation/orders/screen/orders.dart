import 'package:flutter/material.dart';
import 'package:fest_ticketing/presentation/orders/screen/orders_detail.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {"orderId": "#456765", "itemsCount": 4},
    {"orderId": "#454569", "itemsCount": 2},
    {"orderId": "#454809", "itemsCount": 1},
  ];

  OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
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
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(
            orderId: orders[index]['orderId'],
            itemsCount: orders[index]['itemsCount'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersDetailPage(order: orders[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final int itemsCount;
  final VoidCallback? onTap;

  const OrderCard({
    Key? key,
    required this.orderId,
    required this.itemsCount,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.receipt_long, color: Colors.white),
        title: Text("Order $orderId"),
        subtitle: Text("$itemsCount items"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
