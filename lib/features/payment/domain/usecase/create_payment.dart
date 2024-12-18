
import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/payment/domain/repository/payment_repository.dart';

class CreatePaymentUseCase implements UseCase<Either, CreatePaymentRequestParams> {
  final PaymentRepository repository;

  CreatePaymentUseCase({required this.repository});

  Future<Either> call(CreatePaymentRequestParams params) async {
    return await repository.createPayment(params);
  }
}

class CreatePaymentRequestParams {
  final String email;
  final String password;

  CreatePaymentRequestParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
