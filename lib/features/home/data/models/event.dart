import 'dart:convert';

import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/features/home/data/models/event_class.dart';

class Event {
  final String eventId;
  final String name;
  final String description;
  final String image;
  final String location;
  final DateTime date;
  final List<String?> categories;
  final List<EventClass?> classes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.eventId,
    required this.name,
    required this.description,
    required this.image,
    required this.location,
    required this.date,
    required this.categories,
    required this.classes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'event_id': eventId,
      'name': name,
      'description': description,
      'image': image,
      'location': location,
      'categories': categories,
      'date': date.toIso8601String(),
      'event_classes': classes.map((x) => x?.toMap()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventId: map['event_id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      location: map['location'],
      date: DateTime.parse(map['date']),
      categories:
          map['categories'] != null ? List<String>.from(map['categories']) : [],
      classes: map['event_classes'] == null
          ? []
          : List<EventClass>.from(
              map['event_classes']?.map((x) => EventClass.fromMap(x))),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}

extension EventExtension on Event {
  EventEntity toEntity() {
    return EventEntity(
      eventId: eventId,
      name: name,
      description: description,
      image: image,
      date: date,
      location: location,
      categories: categories,
      // classes: classes.map((e) => e.toEntity()).toList(),
      classes: classes.map((e) => e?.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
