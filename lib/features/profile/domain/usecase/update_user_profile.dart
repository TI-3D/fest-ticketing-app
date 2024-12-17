import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/authentication/data/models/user.dart';
import 'package:fest_ticketing/features/profile/domain/repository/profile_repository.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileUseCase extends UseCase<Either, UpdateProfileRequestParams> {
  final ProfileRepository repository;

  UpdateProfileUseCase({
    required this.repository,
  });
  @override
  Future<Either> call(UpdateProfileRequestParams params) async {
    return await repository.updateProfile(params);
  }
}

class UpdateProfileRequestParams {
  final String fullName;
  final String? phoneNumber;
  final String? address;
  final Gender? gender;
  final DateTime? birthDate;
  final XFile? profilePicture;

  UpdateProfileRequestParams({
    required this.fullName,
    this.phoneNumber,
    this.address,
    this.gender,
    this.birthDate,
    this.profilePicture,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
      'gender': gender?.displayName,
      'birth_date': birthDate?.toIso8601String(),
    };

    // If there's a profile picture, include it as a file upload
    if (profilePicture != null) {
      map['profile_picture'] = await MultipartFile.fromFile(profilePicture!.path);
    }

    final formData = FormData.fromMap(map);

    return formData;
  }
}
