import 'package:fest_ticketing/main.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;

  const PaymentMethod({
    Key? key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentMethod = [
      'Credit Card',
      'Bank Transfer',
      'Paypal',
      'Gopay',
      'DANA',
      'OVO',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            const Text('Payment Method', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: PaymentMethod.length,
        itemBuilder: (context, index) {
          final Method = PaymentMethod[index];
          return ListTile(
            title: Text(Method),
            trailing: selectedPaymentMethod == Method
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () => {
              onPaymentMethodSelected(Method),
              Navigator.pop(context),
            },
          );
        },
      ),
    );
  }
}
