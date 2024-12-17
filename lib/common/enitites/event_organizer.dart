import 'package:fest_ticketing/features/event_organizer/data/models/event_organizer.dart';

class EventOrganizerEntity {
  final String organizerId;
  final String companyName;
  final String companyAddress;
  final String companyPic;
  final String companyEmail;
  final String companyPhone;
  final String companyExperience;
  final String companyPortfolio;
  final EventOrganizerStatus status;
  final String? profilePicture;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventOrganizerEntity({
    required this.organizerId,
    required this.companyName,
    required this.companyAddress,
    required this.companyPic,
    required this.companyEmail,
    required this.companyPhone,
    required this.companyExperience,
    required this.companyPortfolio,
    required this.status,
    this.profilePicture,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
}