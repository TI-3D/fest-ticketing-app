import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  final String ticketClass;
  final int quantity;
  final double price;

  const Checkout({
    Key? key,
    required this.ticketClass,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double subtotal = price * quantity;
    final double serviceFee = subtotal * 0.05;
    final double total = subtotal + serviceFee;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Checkout', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Remove All',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // cart item
              ListTile(
                leading: Image.asset('asset/images/konser1.png', width: 60),
                title: Text('TXT world Tour Act: Promise in Jakarta'),
                subtitle: Text('Class - $ticketClass'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline,
                          color: Colors.red),
                      onPressed: () {
                        // logic decrease
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.green),
                      onPressed: () {
                        // logic increase
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Price Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price Details',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildPriceRow(
                        'Subtotal', 'Rp ${subtotal.toStringAsFixed(0)}'),
                    _buildPriceRow('Tax', 'Rp 0'),
                    _buildPriceRow(
                        'Service Fee', 'Rp ${serviceFee.toStringAsFixed(0)}'),
                    _buildPriceRow('Total', 'Rp ${total.toStringAsFixed(0)}',
                        isBold: true),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // visitor details
              ListTile(
                title: const Text('Visitor Details',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // navigate to visitor details
                },
              ),
              const Divider(),
              // payment method
              ListTile(
                title: const Text('Payment Method',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Credit Card'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // navigate to payment method
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // logic checkout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
