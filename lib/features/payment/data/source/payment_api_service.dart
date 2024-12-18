import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:fest_ticketing/core/errors/server.dart';
import 'package:fest_ticketing/core/network/dio_client.dart';
import 'package:fest_ticketing/features/payment/domain/usecase/create_payment.dart';

abstract class PaymentApiService {
  Future<Either<ServerException, Response>> getPayments();
  Future<Either<ServerException, Response>> getPaymentById(String id);
  Future<Either<ServerException, Response>> createPayment(CreatePaymentRequestParams params);
}

class PaymentApiServiceImpl implements PaymentApiService {
  final DioClient _dioClient;

  PaymentApiServiceImpl({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  @override
  Future<Either<ServerException, Response>> getPayments() async {
    try {
      final Response response = await _dioClient.get(
        ApiUrl.getPayment,
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
  Future<Either<ServerException, Response>> getPaymentById(String id) async {
    try {
      final Response response = await _dioClient.get(
        ApiUrl.getPaymentById(id),
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
  Future<Either<ServerException, Response>> createPayment(CreatePaymentRequestParams params) async {
    try {
      final Response response = await _dioClient.post(
        ApiUrl.createPayment,
        data: params.toMap(),
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