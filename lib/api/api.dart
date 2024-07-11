import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../build_information/build_information.dart';
import '../models/oauth2_response.dart';
import '../models/response_page.dart';
import '../providers/authentication.dart';
import 'accounts.dart';
import 'auth_interceptor.dart';
import 'buildings.dart';
import 'leases.dart';
import 'logging_interceptor.dart';
import 'oauth2.dart';
import 'projects.dart';
import 'requests.dart';
import 'units.dart';

class Api {
  factory Api(ProviderRef<Api> ref) {
    final Api api = Api._(ref);

    api.accounts = AccountsApi(api);
    api.buildings = BuildingsApi(api);
    api.leases = LeasesApi(api);
    api.oAuth2 = OAuth2Api(api);
    api.projects = ProjectsApi(api);
    api.requests = RequestsApi(api);
    api.units = UnitsApi(api);

    api.configureDio();

    return api;
  }

  Api._(this.ref);

  late final AccountsApi accounts;
  late final BuildingsApi buildings;
  late final LeasesApi leases;
  late final OAuth2Api oAuth2;
  late final ProjectsApi projects;
  late final RequestsApi requests;
  late final UnitsApi units;

  final ProviderRef<Api> ref;

  static const String _authorizationStorageKey = 'astrareal_authorization';
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  final Dio dio = Dio();

  Future<OAuth2Response?> getAuthorization() async {
    final String? authorizationString = await _flutterSecureStorage.read(
      key: _authorizationStorageKey,
    );

    if (authorizationString == null) {
      return null;
    }

    final Map<String, dynamic> decodedAuthorizationString = json.decode(
      authorizationString,
    ) as Map<String, dynamic>;

    final OAuth2Response oAuth2Response = OAuth2Response.fromJson(
      decodedAuthorizationString,
    );

    return oAuth2Response;
  }

  Future<OAuth2Response?> setAuthorization(
    OAuth2Response? authorization,
  ) async {
    if (authorization == null) {
      await _flutterSecureStorage.delete(
        key: _authorizationStorageKey,
      );
    } else {
      await _flutterSecureStorage.write(
        key: _authorizationStorageKey,
        value: json.encode(authorization.toJson()),
      );
    }

    ref.invalidate(authenticatedUserProvider);

    return authorization;
  }

  void configureDio() {
    dio.options.baseUrl = buildInformation.apiBaseUrl;

    dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(this),
      if (kDebugMode) LoggingInterceptor(),
    ]);
  }

  Future<T> doRequest<T>(
    String method,
    String path, {
    required T Function(Map<String, dynamic>) converter,
    Map<String, dynamic>? data,
    List<ProviderOrFamily> Function(T)? providerInvalidations,
    Options? options,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.request(
        path,
        data: data,
        options: (options ?? Options()).copyWith(
          method: method,
        ),
      );

      final T convertedResponse = converter(response.data!);

      if (providerInvalidations != null) {
        final List<ProviderOrFamily> providersToInvalidate =
            providerInvalidations(convertedResponse);

        // ignore: prefer_foreach
        for (final ProviderOrFamily provider in providersToInvalidate) {
          ref.invalidate(provider);
        }
      }

      return convertedResponse;
    } on DioException catch (e) {
      throw Exception(
          'Request failed with status code ${e.response?.statusCode}.');
    }
  }

  Future<ResponsePage<T>> doPagedRequest<T>(
    String method,
    String path, {
    required T Function(Map<String, dynamic>) converter,
    Map<String, dynamic>? data,
    List<ProviderOrFamily> Function(ResponsePage<T>)? providerInvalidations,
  }) async {
    return doRequest(
      method,
      path,
      data: data,
      converter: (Map<String, dynamic> json) => ResponsePage<T>.fromJson(
        json,
        (Object? json) => converter((json as Map<String, dynamic>?)!),
      ),
      providerInvalidations: providerInvalidations,
    );
  }
}
