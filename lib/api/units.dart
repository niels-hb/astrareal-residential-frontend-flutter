import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/create_unit_request.dart';
import '../models/unit.dart';
import '../providers/units.dart';
import 'api.dart';
import 'http_method.dart';

class UnitsApi {
  UnitsApi(this.api);

  final Api api;

  static const String base = '/units';

  static Unit _converter(Map<String, dynamic> json) => Unit.fromJson(json);

  Future<Unit> create(CreateUnitRequest unit) => api.doRequest(
        HttpMethod.POST,
        base,
        data: unit.toJson(),
        converter: _converter,
        providerInvalidations: (Unit unit) => <ProviderOrFamily>[
          unitsProvider(unit.building),
        ],
      );

  Future<Unit> setName(Unit unit, String name) => api.doRequest(
        HttpMethod.PUT,
        '$base/${unit.id}/name',
        data: <String, String>{
          'name': name,
        },
        converter: _converter,
        providerInvalidations: (Unit unit) => <ProviderOrFamily>[
          unitsProvider(unit.building),
          unitProvider(unit.id!),
        ],
      );

  Future<Unit> getById(String id) => api.doRequest(
        HttpMethod.GET,
        '$base/$id',
        converter: _converter,
      );
}
