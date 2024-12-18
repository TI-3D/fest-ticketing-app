import 'dart:convert';

import 'package:fest_ticketing/common/enitites/payment.dart';
import 'package:fest_ticketing/features/authentication/data/models/user.dart';
import 'package:fest_ticketing/features/home/data/models/event.dart';
import 'package:fest_ticketing/features/home/data/models/event_class.dart';

part 'enum/payment_method_type.dart';
part 'enum/payment_status.dart';

class Payment {
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
  final User user;
  final Event event;
  final EventClass eventClass;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payment({
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

  Map<String, dynamic> toMap() {
    return {
      'payment_id': paymentId,
      'event_id': eventId,
      'event_class_id': eventClassId,
      'user_id': userId,
      'amount': amount,
      'qty': qty,
      'date': date.toIso8601String(),
      'total': total,
      'payment_status': paymentStatus.toString().split('.').last,
      'payment_method': paymentMethod.toString().split('.').last,
      'user': user.toMap(),
      'event': event.toMap(),
      'event_class': eventClass.toMap(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      paymentId: map['payment_id'],
      eventId: map['event_id'],
      eventClassId: map['event_class_id'],
      userId: map['user_id'],
      amount: map['amount'],
      qty: map['qty'],
      date: DateTime.parse(map['date']),
      total: map['total'],
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toUpperCase() ==
            map['payment_status'].toString().toUpperCase(),
      ),
      paymentMethod: PaymentMethodType.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toUpperCase() ==
            map['payment_method'].toString().toUpperCase(),
      ),
      user: User.fromMap(map['user']),
      event: Event.fromMap(map['event']),
      eventClass: EventClass.fromMap(map['event_class']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));
}

extension PaymentExtension on Payment {
  PaymentEntity toEntity() {
    return PaymentEntity(
      paymentId: paymentId,
      eventId: eventId,
      eventClassId: eventClassId,
      userId: userId,
      amount: amount,
      qty: qty,
      date: date,
      total: total,
      paymentStatus: paymentStatus,
      paymentMethod: paymentMethod,
      user: user.toEntity(),
      event: event.toEntity(),
      eventClass: eventClass.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
