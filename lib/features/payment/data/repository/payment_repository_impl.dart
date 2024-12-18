import 'package:dartz/dartz.dart';
import 'package:fest_ticketing/common/enitites/payment.dart';
import 'package:fest_ticketing/core/errors/failure.dart';
import 'package:fest_ticketing/core/network/connection_checker.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/features/payment/data/models/payment.dart';
import 'package:fest_ticketing/features/payment/data/source/payment_api_service.dart';
import 'package:fest_ticketing/features/payment/domain/repository/payment_repository.dart';
import 'package:fest_ticketing/features/payment/domain/usecase/create_payment.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentApiService remoteDataSource;
  final SecureStorageService localDataSource;
  final ConnectionChecker connectionChecker;

  const PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<PaymentEntity>>> getPayments() async {
    // Cek koneksi internet
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    // Memanggil API untuk mendapatkan event
    final response = await remoteDataSource.getPayments();
    return response.fold(
      (error) => Left(Failure(error.message)), // Jika error terjadi di API
      (data) {
        print(data.data);
        if (data.data['data'] == null || (data.data['data'] as List).isEmpty) {
          return Left(Failure('No data found'));
        }
        final eventList = (data.data['data'] as List);
        return Right(
            eventList.map((e) => Payment.fromMap(e).toEntity()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, List<PaymentEntity>>> getPaymentById(String id) async {
    // Cek koneksi internet
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    // Memanggil API untuk mendapatkan event
    final response = await remoteDataSource.getPaymentById(id);
    return response.fold(
      (error) => Left(Failure(error.message)), // Jika error terjadi di API
      (data) {
        if (data.data['data'] == null || (data.data['data'] as List).isEmpty) {
          return Left(Failure('No data found'));
        }
        final eventList = (data.data['data'] as List);
        return Right(
            eventList.map((e) => Payment.fromMap(e).toEntity()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, PaymentEntity>> createPayment(
      CreatePaymentRequestParams params) async {
    // Cek koneksi internet
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    // Memanggil API untuk mendapatkan event
    final response = await remoteDataSource.createPayment(params);
    return response.fold(
      (error) => Left(Failure(error.message)), // Jika error terjadi di API
      (data) {
        return Right(Payment.fromMap(data.data).toEntity());
      },
    );
  }
}
