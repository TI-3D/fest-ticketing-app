import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/common/enitites/payment.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/features/payment/domain/usecase/create_payment.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentEntity>>> getPayments();
  Future<Either<Failure, List<PaymentEntity>>> getPaymentById(String id);
  Future<Either<Failure, PaymentEntity>> createPayment(CreatePaymentRequestParams params);
}
