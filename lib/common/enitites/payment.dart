import 'dart:convert';

import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/common/enitites/event_class.dart';
import 'package:fest_ticketing/common/enitites/user.dart';
import 'package:fest_ticketing/features/payment/data/models/payment.dart';

class PaymentEntity {
  final String paymentId;
  final String eventId;
  final String eventClassId;
  final String userId;
  final double amount;
  final int qty;
  final DateTime date;
  final double total;
  final PaymentStatus paymentStatus;
  final PaymentMethodType paymentMethod;
  final UserEntity user;
  final EventEntity event;
  final EventClassEntity eventClass;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentEntity({
    required this.paymentId,
    required this.eventId,
    required this.eventClassId,
    required this.userId,
    required this.amount,
    required this.qty,
    required this.date,
    required this.total,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.user,
    required this.event,
    required this.eventClass,
    required this.createdAt,
    required this.updatedAt,
  });
}