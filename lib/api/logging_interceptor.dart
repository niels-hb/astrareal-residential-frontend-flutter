// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    print(
      'API ${response.statusCode} <= ${response.requestOptions.method} ${response.requestOptions.path}',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'API ${err.response?.statusCode} <= ${err.response?.requestOptions.method} ${err.response?.requestOptions.path}',
    );

    super.onError(err, handler);
  }
}
