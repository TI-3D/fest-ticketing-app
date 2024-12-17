import 'dart:convert';
import 'package:fest_ticketing/common/enitites/event_organizer.dart';

part 'enum/event_organizer_status.dart';

class EventOrganizer {
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

  EventOrganizer({
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

  Map<String, dynamic> toMap() {
    return {
      'organizer_id': organizerId,
      'company_name': companyName,
      'company_address': companyAddress,
      'company_pic': companyPic,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'company_experience': companyExperience,
      'company_portofolio': companyPortfolio,
      'status': status.toString().split('.').last,
      'profile_picture': profilePicture,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory EventOrganizer.fromMap(Map<String, dynamic> map) {
    return EventOrganizer(
      organizerId: map['organizer_id'],
      companyName: map['company_name'],
      companyAddress: map['company_address'],
      companyPic: map['company_pic'],
      companyEmail: map['company_email'],
      companyPhone: map['company_phone'],
      companyExperience: map['company_experience'],
      companyPortfolio: map['company_portofolio'],
      status: EventOrganizerStatus.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toUpperCase() ==
            map['status'].toString().toUpperCase(),
      ),
      profilePicture: map['profile_picture'],
      userId: map['user_id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventOrganizer.fromJson(String source) =>
      EventOrganizer.fromMap(json.decode(source));
}

extension EventOrganizerExtension on EventOrganizer {
  EventOrganizerEntity toEntity() {
    return EventOrganizerEntity(
      organizerId: organizerId,
      companyName: companyName,
      companyAddress: companyAddress,
      companyPic: companyPic,
      companyEmail: companyEmail,
      companyPhone: companyPhone,
      companyExperience: companyExperience,
      companyPortfolio: companyPortfolio,
      status: status,
      profilePicture: profilePicture,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
