import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/address.dart';
import '../models/building.dart';
import '../models/request.dart';
import '../models/response_page.dart';
import '../models/unit.dart';
import '../providers/buildings.dart';
import 'api.dart';
import 'http_method.dart';

class BuildingsApi {
  BuildingsApi(this.api);

  final Api api;

  static const String base = '/buildings';

  static Building _converter(Map<String, dynamic> json) =>
      Building.fromJson(json);

  Future<ResponsePage<Unit>> getUnitsOfBuilding(Building building) =>
      api.doPagedRequest(
        HttpMethod.GET,
        '$base/${building.id}/units',
        converter: (Map<String, dynamic> json) => Unit.fromJson(json),
      );

  Future<Building> create(Building building) => api.doRequest(
        HttpMethod.POST,
        base,
        data: building.toJson(),
        converter: _converter,
        providerInvalidations: (Building building) => <ProviderOrFamily>[
          buildingsProvider(building.project),
        ],
      );

  Future<Building> getById(String id) => api.doRequest(
        HttpMethod.GET,
        '$base/$id',
        converter: _converter,
      );

  Future<Building> setName(Building building, String name) => api.doRequest(
        HttpMethod.PUT,
        '$base/${building.id}/name',
        data: <String, String>{
          'name': name,
        },
        converter: _converter,
        providerInvalidations: (Building building) => <ProviderOrFamily>[
          buildingsProvider(building.project),
          buildingProvider(building.id!),
        ],
      );

  Future<Building> setAddress(
    Building building,
    Address address,
  ) =>
      api.doRequest(
        HttpMethod.PUT,
        '$base/${building.id}/address',
        data: address.toJson(),
        converter: _converter,
        providerInvalidations: (Building building) => <ProviderOrFamily>[
          buildingsProvider(building.project),
          buildingProvider(building.id!),
        ],
      );

  Future<Building> setTelephoneNumberOffice(
    Building building,
    String? telephoneNumberOffice,
  ) =>
      api.doRequest(
        HttpMethod.PUT,
        '$base/${building.id}/telephone_number_office',
        data: <String, String?>{
          'telephoneNumber': telephoneNumberOffice?.isNotEmpty ?? false
              ? telephoneNumberOffice
              : null,
        },
        converter: _converter,
        providerInvalidations: (Building building) => <ProviderOrFamily>[
          buildingsProvider(building.project),
          buildingProvider(building.id!),
        ],
      );

  Future<Building> setTelephoneNumberReception(
    Building building,
    String? telephoneNumberReception,
  ) =>
      api.doRequest(
        HttpMethod.PUT,
        '$base/${building.id}/telephone_number_reception',
        data: <String, String?>{
          'telephoneNumber': telephoneNumberReception?.isNotEmpty ?? false
              ? telephoneNumberReception
              : null,
        },
        converter: _converter,
        providerInvalidations: (Building building) => <ProviderOrFamily>[
          buildingsProvider(building.project),
          buildingProvider(building.id!),
        ],
      );

  Future<Building> setTelephoneNumberSecurity(
    Building building,
    String? telephoneNumberSecurity,
  ) =>
      api.doRequest(
        HttpMethod.PUT,
        '$base/${building.id}/telephone_number_security',
        data: <String, String?>{
          'telephoneNumber': telephoneNumberSecurity?.isNotEmpty ?? false
              ? telephoneNumberSecurity
              : null,
        },
        converter: _converter,
        providerInvalidations: (Building building) => <ProviderOrFamily>[
          buildingsProvider(building.project),
          buildingProvider(building.id!),
        ],
      );

  Future<ResponsePage<Request>> getRequestsOfBuilding(Building building) =>
      api.doPagedRequest(
        HttpMethod.GET,
        '$base/${building.id}/requests',
        converter: (Map<String, dynamic> json) => Request.fromJson(json),
      );
}
