import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/event_organizer/domain/repository/event_organizer_repository.dart';

class CreateEventOrganizerUseCase extends UseCase<Either, CreateEventOrganizerRequestParams> {
  final EventOrganizerRepository repository;

  CreateEventOrganizerUseCase({
    required this.repository,
  });
  @override
  Future<Either> call(CreateEventOrganizerRequestParams params) async {
    return await repository.createEventOrganizer(params);
  }
}

class CreateEventOrganizerRequestParams {
  final String companyName;
  final String companyPIC;
  final String companyEmail;
  final String companyPhone;
  final String companyAddress;
  final String companyExperience;
  final String companyPortofolio;

  CreateEventOrganizerRequestParams({
    required this.companyName,
    required this.companyPIC,
    required this.companyEmail,
    required this.companyPhone,
    required this.companyAddress,
    required this.companyExperience,
    required this.companyPortofolio,
  });

  Map<String, dynamic> toMap() {
    return {
      'company_name': companyName,
      'company_pic': companyPIC,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'company_address': companyAddress,
      'company_experience': companyExperience,
      'company_portofolio': companyPortofolio,
    };
  }
}
