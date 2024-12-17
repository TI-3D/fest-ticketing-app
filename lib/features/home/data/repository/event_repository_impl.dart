import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/core/network/connection_checker.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/features/home/data/models/event.dart';
import 'package:fest_ticketing/features/home/data/source/event_api_service.dart';
import 'package:fest_ticketing/features/home/domain/repository/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventApiService remoteDataSource;
  final SecureStorageService localDataSource;
  final ConnectionChecker connectionChecker;

  const EventRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    // Cek koneksi internet
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    // Memanggil API untuk mendapatkan event
    final response = await remoteDataSource.getEvent();
    return response.fold(
      (error) => Left(Failure(error.message)), // Jika error terjadi di API
      (data) {
        if (data.data['data'] == null || (data.data['data'] as List).isEmpty) {
          return Left(Failure('No data found'));
        }
        final eventList = (data.data['data'] as List);
        return Right(
            eventList.map((e) => Event.fromMap(e).toEntity()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    // Cek koneksi internet
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    // Memanggil API untuk mendapatkan kategori
    final response = await remoteDataSource.getCategories();
    return response.fold(
      (error) => Left(Failure(error.message)), // Jika error terjadi di API
      (data) {
        final categoryList = List<String>.from(data.data['data']);
        if (categoryList.isEmpty) {
          return Left(Failure('No data found'));
        }
        return Right(categoryList);
      },
    );
  }
}
