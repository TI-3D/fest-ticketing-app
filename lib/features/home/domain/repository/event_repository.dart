import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/core/errors/failure.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventEntity>>> getEvents();
  Future<Either<Failure, List<String>>> getCategories();
}
