enum Gender {
  MALE,
  FEMALE,
}

extension GenderExtension on Gender {
  String get displayName {
    switch (this) {
      case Gender.MALE:
        return 'Male';
      case Gender.FEMALE:
        return 'Female';
    }
  }
}
