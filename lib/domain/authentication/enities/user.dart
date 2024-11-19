
import 'package:fest_ticketing/data/authentication/models/enum/role.dart';
import 'package:fest_ticketing/data/authentication/models/enum/user_status.dart';
import 'package:fest_ticketing/presentation/authentication/screen/signup.dart';

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
  final UserStatus status;
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
    this.status = UserStatus.BASIC,
    required this.createdAt,
    required this.updatedAt,
  });
}


