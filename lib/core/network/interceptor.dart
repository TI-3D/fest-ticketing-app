import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/service_locator.dart';
import 'package:logger/logger.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); //Error log
    logger.d('Error type: ${err.error} \n '
        'Error message: ${err.message}'); //Debug log
    handler.next(err); //Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath'); //Info log
    logger.i('Request headers: ${options.headers}');
    handler.next(options); // continue with the Request
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   if (response != null) {
  //     if (response.data != null) {
  //       logger.d('STATUSCODE: ${response.statusCode} \n'
  //           'STATUSMESSAGE: ${response.statusMessage} \n'
  //           'HEADERS: ${response.headers} \n'
  //           'Data: ${response.data}');
  //     } else {
  //       logger.w(
  //           'Data is null or empty for the response from ${response.requestOptions.path}');
  //     }
  //   } else {
  //     logger.e('Response is null');
  //   }
  //   handler.next(response); // Melanjutkan respons
  // }
}

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await sl<SecureStorageService>().read('access_token');
    print('Token: $token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      print('Unauthorized error encountered. Removing token and signing out.');
      // Remove the token from secure storage
      await sl<SecureStorageService>().remove('access_token');
      // await sl<AuthBloc>().add(SignOutEvent());
    }
    // Pass the error to the next handler
    handler.next(err);
  }
}
