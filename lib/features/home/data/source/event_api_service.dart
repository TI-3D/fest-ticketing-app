import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:fest_ticketing/core/errors/server.dart';
import 'package:fest_ticketing/core/network/dio_client.dart';

abstract class EventApiService {
  Future<Either<ServerException, Response>> getEvent();
  Future<Either<ServerException, Response>> getCategories();
}

class EventApiServiceImpl implements EventApiService {
  final DioClient _dioClient;

  EventApiServiceImpl({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  @override
  Future<Either<ServerException, Response>> getEvent() async {
    try {
      final Response response = await _dioClient.get(
        ApiUrl.getEvent,
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

  @override
  Future<Either<ServerException, Response>> getCategories() async {
    try {
      final Response response = await _dioClient.get(
        ApiUrl.getCategories,
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
