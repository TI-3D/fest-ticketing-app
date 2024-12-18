
import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/payment/data/models/payment.dart';
import 'package:fest_ticketing/features/payment/domain/repository/payment_repository.dart';

class CreatePaymentUseCase implements UseCase<Either, CreatePaymentRequestParams> {
  final PaymentRepository repository;

  CreatePaymentUseCase({required this.repository});

  Future<Either> call(CreatePaymentRequestParams params) async {
    return await repository.createPayment(params);
  }
}

class CreatePaymentRequestParams {
  final double amount;
  final int qty;
  final double total;
  final String eventId; // UUID as String
  final String eventClassId; // UUID as String
  final PaymentMethodType paymentMethod;

  CreatePaymentRequestParams({
    required this.amount,
    required this.qty,
    required this.total,
    required this.eventId,
    required this.eventClassId,
    required this.paymentMethod,
  });

  // Convert the object to a Map to send over HTTP (JSON format)
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'qty': qty,
      'total': total,
      'event_id': eventId,
      'event_class_id': eventClassId,
      'payment_method': paymentMethod.displayName,
    };
  }

}
