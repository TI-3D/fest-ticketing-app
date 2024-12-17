import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:fest_ticketing/core/errors/server.dart';
import 'package:fest_ticketing/core/network/dio_client.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/update_event_organizer.dart';

abstract class EventOrganizerApiService {
  Future<Either<ServerException, Response>> createEventOrganizer(
      CreateEventOrganizerRequestParams params);
  Future<Either<ServerException, Response>> createEvent(
      CreateEventRequestParams params);

  Future<Either<ServerException, Response>> getEventOrganizer();
  Future<Either<ServerException, Response>> getMyEvents();
  Future<Either<ServerException, Response>> updateEventOrganizer(
      UpdateEventOrganizerRequestParams params);
}

class EventOrganizerApiServiceImpl implements EventOrganizerApiService {
  final DioClient _dioClient;

  EventOrganizerApiServiceImpl({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  @override
  Future<Either<ServerException, Response>> createEventOrganizer(
      CreateEventOrganizerRequestParams params) async {
    try {
      final response = await _dioClient.post(
        ApiUrl.createEventOrganizer,
        data: params.toMap(),
      );
      if (response.statusCode == 201) {
        return Right(response);
      } else {
        return Left(ServerException(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(
          ServerException(e.response?.data['message'] ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<ServerException, Response>> createEvent(
      CreateEventRequestParams params) async {
    try {
      final FormData formData = await params.toFormData();
      final response = await _dioClient.post(
        ApiUrl.createEvent,
        data: formData,
      );

      print("Event creation response: ${response.data}");
      if (response.statusCode == 201) {
        return Right(response);
      } else {
        return Left(ServerException(response.data['message']));
      }
    } on DioException catch (e) {
      print("Event creation response: ${e.response?.data}");
      return Left(
          ServerException(e.response?.data['message'] ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<ServerException, Response>> getEventOrganizer() async {
    try {
      final response = await _dioClient.get(
        ApiUrl.getMeEventOrganizer,
      );
      // response status code 200
      if (response.statusCode == 200 || response.statusCode == 202) {
        return Right(response);
      } else {
        return Left(ServerException(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(
          ServerException(e.response?.data['message'] ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<ServerException, Response>> getMyEvents() async {
    try {
      final response = await _dioClient.get(
        ApiUrl.getMyEvents,
      );
      // response status code 200
      if (response.statusCode == 200 || response.statusCode == 202) {
        return Right(response);
      } else {
        return Left(ServerException(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(
          ServerException(e.response?.data['message'] ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<ServerException, Response>> updateEventOrganizer(
      UpdateEventOrganizerRequestParams params) async {
    try {
      final formData = FormData.fromMap(await params.toMap());
      final response = await _dioClient.put(
        ApiUrl.updateEventOrganizer(params.organizerId),
        data: formData,
      );
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(ServerException(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(
          ServerException(e.response?.data['message'] ?? 'Unknown error'));
    }
  }
}
