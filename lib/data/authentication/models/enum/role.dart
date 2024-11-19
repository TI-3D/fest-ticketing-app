enum Role {
  USER,
  EO,
  ADMIN,
}

extension RoleExtension on Role {
  String get displayName {
    switch (this) {
      case Role.USER:
        return 'User';
      case Role.EO:
        return 'Event Organizer';
      case Role.ADMIN:
        return 'Admin';
    }
  }
}
