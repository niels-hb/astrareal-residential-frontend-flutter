import 'package:dio/dio.dart';

import '../models/oauth2_response.dart';
import 'api.dart';
import 'http_method.dart';

class OAuth2Api {
  OAuth2Api(this.api);

  final Api api;

  static const String base = '/oauth2';

  static OAuth2Response _converter(Map<String, dynamic> json) =>
      OAuth2Response.fromJson(json);

  Future<OAuth2Response?> passwordLogin(
    String username,
    String password,
  ) async {
    final OAuth2Response response = await api.doRequest(
      HttpMethod.POST,
      '$base/token',
      data: <String, String>{
        'grant_type': 'password',
        'username': username,
        'password': password,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
      converter: _converter,
    );

    return api.setAuthorization(response);
  }

  Future<OAuth2Response?> refreshTokenLogin(
    OAuth2Response? currentAuthorization,
  ) async {
    if (currentAuthorization == null) {
      throw Exception('No authenticated user.');
    }

    final OAuth2Response response = await api.doRequest(
      HttpMethod.POST,
      '$base/token',
      data: <String, String>{
        'grant_type': 'refresh_token',
        'refresh_token': currentAuthorization.refreshToken,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
      converter: _converter,
    );

    return api.setAuthorization(response);
  }
}
