import 'package:fest_ticketing/common/enitites/event_class.dart';

class EventEntity {
  final String eventId;
  final String name;
  final String description;
  final String image;
  final String location;
  final DateTime date;
  final List<String> categories;
  final List<EventClassEntity> classes;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventEntity({
    required this.eventId,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.image,
    required this.categories,
    required this.classes,
    required this.createdAt,
    required this.updatedAt,
  });
}

