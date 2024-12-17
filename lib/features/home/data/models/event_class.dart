import 'package:fest_ticketing/common/enitites/event_class.dart';

class EventClass {
  final String eventClassId;
  final String eventId;
  final String className;
  final double basePrice;
  final int count;
  final String? description;

  EventClass({
    required this.eventClassId,
    required this.eventId,
    required this.className,
    required this.basePrice,
    required this.count,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'event_class_id': eventClassId,
      'event_id': eventId,
      'class_name': className,
      'base_price': basePrice,
      'count': count,
      'description': description,
    };
  }

  factory EventClass.fromMap(Map<String, dynamic> map) {
    return EventClass(
      eventClassId: map['event_class_id'],
      eventId: map['event_id'],
      className: map['class_name'],
      basePrice: double.tryParse(map['base_price'].toString()) ?? 0,
      count: map['count'],
      description: map['description'],
    );
  }
}

extension EventClassExtension on EventClass {
  EventClassEntity toEntity() {
    return EventClassEntity(
      eventClassId: eventClassId,
      eventId: eventId,
      className: className,
      basePrice: basePrice,
      count: count,
      description: description,
    );
  }
}
