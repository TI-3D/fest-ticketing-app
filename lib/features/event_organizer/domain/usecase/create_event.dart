import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/common/enitites/event_class.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/features/event_organizer/domain/repository/event_organizer_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart'; // Make sure to import Dio for MultipartFile

class CreateEventUseCase {
  final EventOrganizerRepository repository;

  CreateEventUseCase({required this.repository});

  Future<Either<Failure, Map<String, dynamic>>> call(
      CreateEventRequestParams params) async {
    return await repository.createEvent(params);
  }
}

class CreateEventRequestParams {
  final String name;
  final String description;
  final String location;
  final String date; // Pastikan format tanggal sesuai
  final List<String> categories; // Ubah menjadi List<String>
  final List<EventClassEntity> eventClasses;
  final XFile? eventImage;

  CreateEventRequestParams({
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.categories,
    required this.eventClasses,
    this.eventImage,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {
      'name': name,
      'description': description,
      'location': location,
      'date': date,
      'categories': categories,
    };

    eventClasses.asMap().forEach((index, eventClass) {
      map['event_classes_class_name'] = eventClass.className;
      map['event_classes_base_price'] = eventClass.basePrice;
      map['event_classes_count'] = eventClass.count;
    });

    if (eventImage != null) {
      map['image'] = await MultipartFile.fromFile(eventImage!.path);
    }

    // Create FormData
    final formData = FormData.fromMap(map);

    return formData;
  }
}
