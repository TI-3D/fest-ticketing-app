class EventClassEntity {
  final String? eventClassId;
  final String eventId;
  final String className;
  final double basePrice;
  final int count;
  final String? description;

  EventClassEntity({
    required this.eventClassId,
    required this.eventId,
    required this.className,
    required this.basePrice,
    required this.count,
    required this.description,
  });
}