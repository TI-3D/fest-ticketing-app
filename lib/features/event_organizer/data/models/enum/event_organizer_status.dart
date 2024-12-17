part of '../event_organizer.dart';

enum EventOrganizerStatus {
  PENDING,
  ACTIVE,
  INACTIVE,
}

extension EventOrganizerStatusExtension on EventOrganizerStatus {
  String get displayName {
    switch (this) {
      case EventOrganizerStatus.PENDING:
        return 'Pending';
      case EventOrganizerStatus.ACTIVE:
        return 'Active';
      case EventOrganizerStatus.INACTIVE:
        return 'Inactive';
    }
  }
}
