import 'dart:convert';
import 'package:fest_ticketing/data/authentication/models/enum/role.dart';
import 'package:fest_ticketing/data/authentication/models/enum/user_status.dart';
import 'package:fest_ticketing/domain/authentication/enities/user.dart';
import 'package:fest_ticketing/presentation/authentication/screen/signup.dart';

class User {
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

  User({
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

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'email': email,
      'gender': gender?.toString().split('.').last,
      'birth_date': birthDate?.toIso8601String(),
      'phone_number': phoneNumber,
      'nik': nik,
      'address': address,
      'role': role.toString().split('.').last,
      'status': status.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      email: map['email'],
      fullName: map['full_name'],
      gender: map['gender'] != null
          ? Gender.values.firstWhere(
              (e) => e.toString().split('.').last == map['gender'],
            )
          : null,
      birthDate: map['birth_date'] != null
          ? DateTime.tryParse(map['birth_date'])
          : null,
      phoneNumber: map['phone_number'],
      nik: map['nik'],
      address: map['address'],
      role: Role.values.firstWhere(
        (e) => e.toString().split('.').last == map['role'],
        orElse: () => Role.USER,
      ),
      status: UserStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['status'],
        orElse: () => UserStatus.BASIC,
      ),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

extension UserExtension on User{
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      gender: gender,
      birthDate: birthDate,
      phoneNumber: phoneNumber,
      nik: nik,
      address: address,
      role: role,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
