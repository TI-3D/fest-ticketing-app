part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PaymentEntity> payments;

  const PaymentLoaded(this.payments);

  @override
  List<Object> get props => [payments];
}

class PaymentDetailLoaded extends PaymentState {
  final PaymentEntity payment;

  const PaymentDetailLoaded(this.payment);

  @override
  List<Object> get props => [payment];
}

class PaymentSuccess extends PaymentState {}

class PaymentFailure extends PaymentState {
  final String message;

  const PaymentFailure(this.message);

  @override
  List<Object> get props => [message];
}