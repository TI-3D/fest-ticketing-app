import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/payment/domain/repository/payment_repository.dart';

class GetAllPaymentUseCase implements UseCaseNoParams<Either> {
  final PaymentRepository repository;

  GetAllPaymentUseCase({required this.repository});

  Future<Either> call() async {
    return await repository.getPayments();
  }
}
