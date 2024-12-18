import 'package:fest_ticketing/features/payment/data/models/payment.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  final PaymentMethodType selectedPaymentMethod;
  final Function(PaymentMethodType) onPaymentMethodSelected;

  const PaymentMethod({
    Key? key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
      ),
      body: ListView(
        children: PaymentMethodType.values.map((method) {
          return ListTile(
            title: Text(method.displayName),
            selected: method == selectedPaymentMethod,
            onTap: () {
              onPaymentMethodSelected(method); // Pass the enum value
              Navigator.pop(context, method); // Return the enum value
            },
          );
        }).toList(),
      ),
    );
  }
}