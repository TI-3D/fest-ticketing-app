import 'package:fest_ticketing/common/enitites/payment.dart';
import 'package:fest_ticketing/features/payment/data/models/payment.dart';
import 'package:fest_ticketing/features/payment/presentation/bloc/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_detail.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    // Memanggil fetchPaymentAll saat halaman dimuat
    context.read<PaymentCubit>().fetchPaymentAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          print(state);
          if (state is PaymentLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PaymentFailure) {
            return Center(child: Text('${state.message}'));
          } else if (state is PaymentLoaded) {
            return Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: state.payments.length,
                itemBuilder: (context, index) {
                  return OrderCard(
                    order: state.payments[index], // Menggunakan PaymentEntity
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersDetailsPage(
                            order: state
                                .payments[index], // Menggunakan PaymentEntity
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is PaymentFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No orders found.'));
          }
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final PaymentEntity order; // Menggunakan PaymentEntity
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (order.paymentStatus) {
      case PaymentStatus.PENDING:
        statusColor = Colors.orange;
        break;
      case PaymentStatus.COMPLETED:
        statusColor = Colors.green;
        break;
      case PaymentStatus.CANCELLED:
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
                order.event.name, // Menggunakan nama event
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${order.date.day} - ${order.date.month} - ${order.date.year}", // Format tanggal
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
                  order.paymentStatus == PaymentStatus.PENDING
                      ? "Pending"
                      : order.paymentStatus == PaymentStatus.COMPLETED
                          ? "Completed"
                          : "Cancelled",
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
