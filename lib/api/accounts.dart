import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/account.dart';
import '../models/address.dart';
import '../models/lease.dart';
import '../models/password_change_request.dart';
import '../models/request.dart';
import '../models/response_page.dart';
import '../models/unit.dart';
import '../providers/authentication.dart';
import 'api.dart';
import 'http_method.dart';

class AccountsApi {
  AccountsApi(this.api);

  final Api api;

  static const String base = '/accounts';

  static Account _converter(Map<String, dynamic> json) =>
      Account.fromJson(json);

  Future<ResponsePage<Account>> get() => api.doPagedRequest(
        HttpMethod.GET,
        base,
        converter: _converter,
      );

  Future<Account> getById(String id) => api.doRequest(
        HttpMethod.GET,
        '$base/$id',
        converter: _converter,
      );

  Future<Account> createPersonal(Account account) => api.doRequest(
        HttpMethod.POST,
        '$base/personal',
        data: account.toJson(),
        converter: _converter,
      );

  Future<Account> createCompany(Account account) => api.doRequest(
        HttpMethod.POST,
        '$base/company',
        data: account.toJson(),
        converter: _converter,
      );

  Future<Account> setAddress(Account account, Address address) => api.doRequest(
        HttpMethod.PUT,
        '$base/${account.id}/address',
        data: address.toJson(),
        converter: _converter,
        providerInvalidations: (_) => <ProviderOrFamily>[
          authenticatedUserProvider,
        ],
      );

  Future<Account> setEmail(Account account, String email) => api.doRequest(
        HttpMethod.PUT,
        '$base/${account.id}/email',
        data: <String, String>{
          'email': email,
        },
        converter: _converter,
        providerInvalidations: (_) => <ProviderOrFamily>[
          authenticatedUserProvider,
        ],
      );

  Future<Account> setTelephoneNumber(
    Account account,
    String telephoneNumber,
  ) =>
      api.doRequest(
        HttpMethod.PUT,
        '$base/${account.id}/telephone_number',
        data: <String, String>{
          'telephoneNumber': telephoneNumber,
        },
        converter: _converter,
        providerInvalidations: (_) => <ProviderOrFamily>[
          authenticatedUserProvider,
        ],
      );

  Future<Account> setPassword(
    Account account,
    PasswordChangeRequest passwordChangeRequest,
  ) =>
      api.doRequest(
        HttpMethod.PUT,
        '$base/${account.id}/password',
        data: passwordChangeRequest.toJson(),
        converter: _converter,
        providerInvalidations: (_) => <ProviderOrFamily>[
          authenticatedUserProvider,
        ],
      );

  Future<ResponsePage<Unit>> getOwnedUnits(String id) => api.doPagedRequest(
        HttpMethod.GET,
        '$base/$id/units',
        converter: (Map<String, dynamic> json) => Unit.fromJson(json),
      );

  Future<ResponsePage<Lease>> getLeases(String id) => api.doPagedRequest(
        HttpMethod.GET,
        '$base/$id/leases',
        converter: (Map<String, dynamic> json) => Lease.fromJson(json),
      );

  Future<ResponsePage<Request>> getRequests(String id) => api.doPagedRequest(
        HttpMethod.GET,
        '$base/$id/requests',
        converter: (Map<String, dynamic> json) => Request.fromJson(json),
      );
}
