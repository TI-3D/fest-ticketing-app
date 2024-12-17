import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/core/usecase/usercase.dart';
import 'package:fest_ticketing/features/home/domain/repository/event_repository.dart';

class GetCategoriesUseCase implements UseCaseNoParams<Either> {
  final EventRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<Either> call() async {
    return await repository.getCategories();
  }
}