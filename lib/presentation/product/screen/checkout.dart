import 'package:fest_ticketing/features/payment/data/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/features/product/presentation/pages/payment_method.dart';
import 'package:fest_ticketing/presentation/product/screen/purchase_succes.dart';

class Checkout extends StatefulWidget {
  final DateTime date;
  final String location;
  final String ticketClass;
  final int quantity;
  final double price;

  const Checkout({
    Key? key,
    required this.date,
    required this.location,
    required this.ticketClass,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  PaymentMethodType selectedPaymentMethod = PaymentMethodType.CREDIT_CARD;

  @override
  Widget build(BuildContext context) {
    final double subtotal = widget.price * widget.quantity;
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
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/images/konser1.png', // Replace with the correct image path
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TXT World Tour Act: Promise in Jakarta',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Class - ${widget.ticketClass}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32, color: Colors.grey),

                // Detail Event
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailEvent(
                              'Date', 'Friday, December 15, 2024'),
                          const SizedBox(height: 8),
                          _buildDetailEvent(
                              'Location', 'Istora Senayan, Jakarta'),
                          const SizedBox(height: 8),
                          _buildDetailEvent('Time', '19:00 - 22:00'),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _buildPriceRow('Subtotal',
                                'Rp ${subtotal.toStringAsFixed(0)}'),
                            _buildPriceRow('Tax', 'Rp 0'),
                            _buildPriceRow('Service Fee',
                                'Rp ${serviceFee.toStringAsFixed(0)}'),
                            _buildPriceRow(
                                'Total', 'Rp ${total.toStringAsFixed(0)}',
                                isBold: true),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      // Payment Method
                      ListTile(
                        title: const Text('Payment Method',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(selectedPaymentMethod.displayName),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentMethod(
                                selectedPaymentMethod:
                                    selectedPaymentMethod.displayName,
                                onPaymentMethodSelected: (method) {
                                  setState(() {
                                    selectedPaymentMethod =
                                        PaymentMethodType.values.firstWhere(
                                            (e) => e.displayName == method);
                                  });
                                },
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              selectedPaymentMethod = result;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      // Checkout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            switch (selectedPaymentMethod) {
                              case PaymentMethodType.CREDIT_CARD:
                                // Credit Card Payment
                                break;
                              case PaymentMethodType.GOPAY:
                                // Gopay Payment
                                break;
                              case PaymentMethodType.DANA:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PurchaseSucces()),
                                );
                                break;
                              case PaymentMethodType.OVO:
                                // OVO Payment
                                break;
                              // Add other cases as needed
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
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
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailEvent(
    String label,
    String value, {
    bool isBold = false,
    Color? labelColor,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: labelColor ?? Colors.black87,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor ?? Colors.black54,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
