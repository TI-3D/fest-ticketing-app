import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/event_organizer/domain/repository/event_organizer_repository.dart';
import 'package:image_picker/image_picker.dart';

class UpdateEventOrganizerUseCase
    extends UseCase<Either, UpdateEventOrganizerRequestParams> {
  final EventOrganizerRepository repository;

  UpdateEventOrganizerUseCase({
    required this.repository,
  });
  @override
  Future<Either> call(UpdateEventOrganizerRequestParams params) async {
    return await repository.updateEventOrganizer(params);
  }
}

class UpdateEventOrganizerRequestParams {
  final String organizerId;
  final String companyName;
  final String companyPIC;
  final String companyEmail;
  final String companyPhone;
  final String companyAddress;
  final String companyExperience;
  final String companyPortofolio;
  final XFile? profilePicture;
  final String profilePictureUrl;

  UpdateEventOrganizerRequestParams({
    required this.organizerId,
    required this.companyName,
    required this.companyPIC,
    required this.companyEmail,
    required this.companyPhone,
    required this.companyAddress,
    required this.companyExperience,
    required this.companyPortofolio,
    this.profilePicture,
    required this.profilePictureUrl,
  });

  Future<Map<String, dynamic>> toMap() async {
    final Map<String, dynamic> map = {
      'organizer_id': organizerId,
      'company_name': companyName,
      'company_pic': companyPIC,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'company_address': companyAddress,
      'company_experience': companyExperience,
      'company_portofolio': companyPortofolio,
    };

    if (profilePicture != null) {
      final MultipartFile file =
          await MultipartFile.fromFile(profilePicture!.path);
      map['profile_picture'] = file;
    }

    if (profilePicture == null && profilePictureUrl.isNotEmpty) {
      map['profile_picture_url'] = profilePictureUrl;
    }

    return map;
  }
}
