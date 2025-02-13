import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/furniture_request.dart';
import '../models/request.dart';
import '../models/response_page.dart';
import '../providers/requests.dart';
import 'api.dart';
import 'http_method.dart';

class RequestsApi {
  RequestsApi(this.api);

  final Api api;

  static const String base = '/requests';

  static Request _converter(Map<String, dynamic> json) =>
      Request.fromJson(json);

  Future<ResponsePage<Request>> get() => api.doPagedRequest(
        HttpMethod.GET,
        base,
        converter: _converter,
      );

  Future<FurnitureRequest> createFurnitureRequest(
    FurnitureRequest request,
  ) =>
      api.doRequest(
        HttpMethod.POST,
        '$base/furniture',
        data: request.toJson(),
        converter: (Map<String, dynamic> json) =>
            FurnitureRequest.fromJson(json),
        providerInvalidations: (_) => <ProviderOrFamily>[
          requestsOfUserProvider,
        ],
      );

  Future<Request> approve(Request request) => api.doRequest(
        HttpMethod.PUT,
        '$base/${request.id}/approve',
        converter: _converter,
        providerInvalidations: (_) => <ProviderOrFamily>[
          requestsOfUserProvider,
        ],
      );

  Future<Request> deny(Request request, String denialReason) => api.doRequest(
        HttpMethod.PUT,
        '$base/${request.id}/deny',
        data: <String, String>{
          'reason': denialReason,
        },
        converter: _converter,
        providerInvalidations: (_) => <ProviderOrFamily>[
          requestsOfUserProvider,
        ],
      );

  Future<Request> execute(Request request) => api.doRequest(
        HttpMethod.PUT,
        '$base/${request.id}/execute',
        converter: _converter,
        providerInvalidations: (Request r) => <ProviderOrFamily>[
          requestsOfUserProvider,
          requestsOfBuildingProvider(r.unit.building),
        ],
      );

  Future<Request> delete(Request request) => api.doRequest(
        HttpMethod.DELETE,
        '$base/${request.id}',
        converter: _converter,
        providerInvalidations: (_) => <ProviderOrFamily>[
          requestsOfUserProvider,
        ],
      );
}
