
import 'package:fest_ticketing/features/authentication/data/models/user.dart';

class UserEntity {
  final String userId;
  final String fullName;
  final String email;
  final Gender? gender;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? nik;
  final String? address;
  final Role role;
  final String? profilePicture;
  final String? embedding;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserEntity({
    required this.userId,
    required this.email,
    required this.fullName,
    this.gender,
    this.birthDate,
    this.phoneNumber,
    this.nik,
    this.address,
    this.role = Role.USER,
    this.profilePicture,
    this.embedding,
    required this.createdAt,
    required this.updatedAt,
  });
}
