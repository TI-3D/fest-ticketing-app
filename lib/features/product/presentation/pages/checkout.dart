import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/common/enitites/event_class.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_failed.dart';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_warning.dart';
import 'package:fest_ticketing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fest_ticketing/features/liveness_detection/presentation/pages/start_register.dart';
import 'package:fest_ticketing/features/payment/data/models/payment.dart';
import 'package:fest_ticketing/features/payment/domain/usecase/create_payment.dart';
import 'package:fest_ticketing/features/payment/presentation/bloc/payment_cubit.dart';
import 'package:fest_ticketing/features/product/presentation/pages/payment_method.dart';
import 'package:fest_ticketing/presentation/product/screen/purchase_succes.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Checkout extends StatefulWidget {
  final EventEntity event;
  final EventClassEntity ticketClass;
  final int quantity;

  const Checkout({
    Key? key,
    required this.event,
    required this.ticketClass,
    required this.quantity,
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  PaymentMethodType selectedPaymentMethod = PaymentMethodType.CREDIT_CARD;

  @override
  Widget build(BuildContext context) {
    final double subtotal = widget.ticketClass.basePrice * widget.quantity;
    final double total = subtotal;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisteredUncompleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            WarningSnackBar(
                message: 'Registration incomplete. Please try again.'),
          );
          AppNavigator.pushReplacement(context, StartRegister());
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            FailedSnackBar(message: state.message),
          );
        }
      },
      child: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            // Navigate to success page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PurchaseSucces()),
            );
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              FailedSnackBar(message: state.message),
            );
          }
        },
        child: Scaffold(
          appBar: BasicAppbar(
            title: const Text('Checkout'),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEventDetails(),
                    const Divider(height: 32, color: Colors.grey),
                    _buildEventInfo(),
                  ],
                ),
              ),
              _buildPaymentDetails(total),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            widget.event.image,
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
                widget.event.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Class: ${widget.ticketClass.className}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailEvent(
              'Date', widget.event.date.toLocal().toString().split(' ')[0]),
          const SizedBox(height: 8),
          _buildDetailEvent('Location', widget.event.location),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(double total) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Payment Details',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildPriceRow('Subtotal',
                    'Rp ${widget.ticketClass.basePrice * widget.quantity}'),
                _buildPriceRow('Total', 'Rp ${total.toStringAsFixed(0)}',
                    isBold: true),
                const SizedBox(height: 16),
                _buildPaymentMethodSelector(),
                const SizedBox(height: 16),
                _buildCheckoutButton(total),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailEvent(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
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

  Widget _buildPaymentMethodSelector() {
    return ListTile(
      title: const Text('Payment Method',
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(selectedPaymentMethod.displayName),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentMethod(
              selectedPaymentMethod: selectedPaymentMethod,
              onPaymentMethodSelected: (method) {
                setState(() {
                  selectedPaymentMethod = method;
                });
              },
            ),
          ),
        );

        if (result != null) {
          setState(() {
            selectedPaymentMethod =
                result; // Ensure this is a PaymentMethodType
          });
        }
      },
    );
  }

  Widget _buildCheckoutButton(double total) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final paymentParams = CreatePaymentRequestParams(
            amount: total,
            qty: widget.quantity,
            total: total,
            eventId: widget.event.eventId,
            eventClassId: widget.ticketClass.eventClassId,
            paymentMethod: selectedPaymentMethod,
          );

          // Call the createNewPayment method from PaymentCubit
          context.read<PaymentCubit>().createNewPayment(paymentParams);
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
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
