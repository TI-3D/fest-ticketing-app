import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/home/domain/repository/event_repository.dart';

class GetEventUseCase implements UseCaseNoParams<Either> {
  final EventRepository repository;

  GetEventUseCase({required this.repository});

  Future<Either> call() async {
    print('GetEventUseCase');
    return await repository.getEvents();
  }
}
