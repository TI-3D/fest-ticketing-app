import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/payment/domain/repository/payment_repository.dart';

class GetPaymentDetailUseCase implements UseCase<Either, String> {
  final PaymentRepository repository;

  GetPaymentDetailUseCase({required this.repository});

  Future<Either> call(String params) async {
    print('GetEventUseCase');
    return await repository.getPaymentById(params);
  }
}
