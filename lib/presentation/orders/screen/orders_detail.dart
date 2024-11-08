// orders_detail.dart
import 'package:flutter/material.dart';
import 'ticket.dart'; // Pastikan ini adalah halaman ticket yang benar

class OrdersDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrdersDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[600],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Order #454809',
          style: TextStyle(
            color: Color.fromRGBO(117, 117, 117, 1),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white70,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                leading: Image.network(
                  'https://via.placeholder.com/60', // Ganti dengan URL gambar Anda
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.broken_image,
                      size: 60,
                      color: Colors.grey[300],
                    );
                  },
                ),
                title: Text(
                  order['orderId'] ?? 'Unknown Order',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: const Text(
                  'Class - GA',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Package Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Order Detail ID:',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '12343242344134',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Validity Period',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '10 Feb 2024',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          // Tambahkan tindakan yang ingin dilakukan saat "Details" diklik
                          print("Details clicked");
                        },
                        child: Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Contact Info',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Muhammad Anang',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white70,
              child: ListTile(
                title: const Text('Tickets details'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigasi ke halaman Ticket
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Ticket()), // Pastikan Ticket adalah widget yang benar
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
