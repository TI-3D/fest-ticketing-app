import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fest_ticketing/common/enitites/payment.dart';
import 'package:fest_ticketing/features/payment/domain/usecase/get_all_payment.dart';
import 'package:fest_ticketing/features/payment/domain/usecase/get_payment_detail.dart';
import 'package:fest_ticketing/features/payment/domain/usecase/create_payment.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final GetAllPaymentUseCase getAllPayments;
  final GetPaymentDetailUseCase getPaymentDetail;
  final CreatePaymentUseCase createPayment;

  PaymentCubit({
    required this.getAllPayments,
    required this.getPaymentDetail,
    required this.createPayment,
  }) : super(PaymentInitial());

  List<PaymentEntity> _allPayments = [];

  Future<void> fetchPaymentAll() async {
    emit(PaymentLoading());
    final result = await getAllPayments();
    emit(result.fold(
      (failure) {
        return PaymentFailure(failure.message);
      },
      (payments) {
        _allPayments = payments;
        return PaymentLoaded(_allPayments);
      },
    ));
  }

  Future<void> fetchPaymentDetail(String paymentId) async {
    emit(PaymentLoading());
    final result = await getPaymentDetail(paymentId);
    emit(result.fold(
      (failure) {
        print('Failed to load payment detail: ${failure.message}');
        return PaymentFailure(failure.message);
      },
      (payment) {
        return PaymentDetailLoaded(payment);
      },
    ));
  }

  Future<void> createNewPayment(CreatePaymentRequestParams params) async {
    emit(PaymentLoading());
    final result = await createPayment(params);
    emit(result.fold(
      (failure) {
        return PaymentFailure(failure.message);
      },
      (success) {
        return PaymentSuccess();
      },
    ));
  }
}
