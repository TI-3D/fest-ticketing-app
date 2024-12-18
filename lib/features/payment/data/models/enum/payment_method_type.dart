part of '../payment.dart';

enum PaymentMethodType {
  CREDIT_CARD,
  GOPAY,
  DANA,
  OVO,
}

extension PaymentMethodTypeExtension on PaymentMethodType {
  String get displayName {
    switch (this) {
      case PaymentMethodType.CREDIT_CARD:
        return 'CREDIT_CARD';
      case PaymentMethodType.GOPAY:
        return 'GOPAY';
      case PaymentMethodType.DANA:
        return 'DANA';
      case PaymentMethodType.OVO:
        return 'OVO';
    }
  }
}
