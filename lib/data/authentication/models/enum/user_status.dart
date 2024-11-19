enum UserStatus {
  BASIC,
  PREMIUM,
}

extension UserStatusExtension on UserStatus {
  String get displayName {
    switch (this) {
      case UserStatus.BASIC:
        return 'Basic';
      case UserStatus.PREMIUM:
        return 'Premium';
    }
  }
}