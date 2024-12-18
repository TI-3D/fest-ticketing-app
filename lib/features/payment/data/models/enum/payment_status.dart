part of '../payment.dart';

enum PaymentStatus {
  PENDING,
  COMPLETED,
  FAILED,
  CANCELLED,
}

extension PaymentStatusExtension on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.PENDING:
        return 'PENDING';
      case PaymentStatus.COMPLETED:
        return 'COMPLETED';
      case PaymentStatus.FAILED:
        return 'FAILED';
      case PaymentStatus.CANCELLED:
        return 'CANCELLED';
    }
  }
}
