import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/create_lease_request.dart';
import '../models/lease.dart';
import '../models/response_page.dart';
import '../providers/leases.dart';
import 'api.dart';
import 'http_method.dart';

class LeasesApi {
  LeasesApi(this.api);

  final Api api;

  static const String base = '/leases';

  static Lease _converter(Map<String, dynamic> json) => Lease.fromJson(json);

  Future<ResponsePage<Lease>> get() => api.doPagedRequest(
        HttpMethod.GET,
        base,
        converter: _converter,
      );

  Future<Lease> create(CreateLeaseRequest lease) => api.doRequest(
        HttpMethod.POST,
        base,
        data: lease.toJson(),
        converter: _converter,
        providerInvalidations: (_) => <ProviderOrFamily>[
          leasesProvider,
        ],
      );
}
