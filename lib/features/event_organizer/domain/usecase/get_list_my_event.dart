import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/event_organizer/domain/repository/event_organizer_repository.dart';

class GetListMyEventUseCase extends UseCaseNoParams<Either> {
  final EventOrganizerRepository repository;

  GetListMyEventUseCase({
    required this.repository,
  });
  @override
  Future<Either> call() async {
    return await repository.getEventOrganizer();
  }
}
