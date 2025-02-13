import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/oauth2_response.dart';
import 'api.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.api);

  final Api api;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    OAuth2Response? currentAuthorization = await api.getAuthorization();

    if (currentAuthorization == null) {
      handler.next(options);
      return;
    }

    if (options.path != '/oauth2/token' &&
        JwtDecoder.isExpired(currentAuthorization.accessToken)) {
      try {
        currentAuthorization = await api.oAuth2.refreshTokenLogin(
          currentAuthorization,
        );
      } catch (e) {
        api.setAuthorization(null);
      }
    }

    if (currentAuthorization != null) {
      options.headers['Authorization'] =
          '${currentAuthorization.tokenType} ${currentAuthorization.accessToken}';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (!err.requestOptions.path.contains('oauth2') &&
        err.response?.statusCode == HttpStatus.unauthorized) {
      api.setAuthorization(null);
    }

    super.onError(err, handler);
  }
}
