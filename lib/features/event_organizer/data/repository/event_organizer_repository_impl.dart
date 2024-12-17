import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/core/errors/server.dart';
import 'package:fest_ticketing/core/network/connection_checker.dart';
import 'package:fest_ticketing/features/event_organizer/data/source/event_organizer_api_service.dart';
import 'package:fest_ticketing/features/event_organizer/domain/repository/event_organizer_repository.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/update_event_organizer.dart';

class EventOrganizerRepositoryImpl implements EventOrganizerRepository {
  final EventOrganizerApiService remoteDataSource;
  final ConnectionChecker connectionChecker;

  const EventOrganizerRepositoryImpl({
    required this.connectionChecker,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> createEventOrganizer(
      CreateEventOrganizerRequestParams params) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection.'));
      }

      final response = await remoteDataSource.createEventOrganizer(params);
      return response.fold(
        (error) => Left(Failure(error.message)),
        (responseData) {
          if (responseData.data['data'] == null) {
            return Left(Failure(responseData.data['message']));
          }

          return Right(responseData.data['data']);
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createEvent(
      CreateEventRequestParams params) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection.'));
      }

      final response = await remoteDataSource.createEvent(params);
      return response.fold(
        (error) => Left(Failure(error.message)),
        (responseData) {
          if (responseData.data['data'] == null) {
            return Left(Failure(responseData.data['message']));
          }

          return Right(responseData.data);
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getEventOrganizer() async {
    try {
      final response = await remoteDataSource.getEventOrganizer();
      return response.fold(
        (error) => Left(Failure(error.message)),
        (responseData) {
          if (responseData.data['data'] == null) {
            return Left(Failure(responseData.data['message']));
          }
          return Right(responseData.data['data']);
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> updateEventOrganizer(
      UpdateEventOrganizerRequestParams params) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection.'));
      }
      final response = await remoteDataSource.updateEventOrganizer(params);
      return response.fold(
        (error) => Left(Failure(error.message)),
        (responseData) {
          if (responseData.data['data'] == null) {
            return Left(Failure(responseData.data['message']));
          }
          return Right(responseData.data['data']);
        },
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
