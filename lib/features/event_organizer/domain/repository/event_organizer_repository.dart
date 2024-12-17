import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/update_event_organizer.dart';

abstract class EventOrganizerRepository {
  Future<Either<Failure, Map<String, dynamic>>> createEventOrganizer(CreateEventOrganizerRequestParams params);
  Future<Either<Failure, Map<String, dynamic>>> getEventOrganizer();
  Future<Either<Failure, Map<String, dynamic>>> updateEventOrganizer(UpdateEventOrganizerRequestParams params);

  // Event
  Future<Either<Failure, Map<String, dynamic>>> createEvent(CreateEventRequestParams params);
}