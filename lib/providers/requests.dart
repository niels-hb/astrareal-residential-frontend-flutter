import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../models/account.dart';
import '../models/building.dart';
import '../models/request.dart';
import '../models/response_page.dart';
import 'api.dart';
import 'authentication.dart';

FutureProvider<ResponsePage<Request>> requestsOfUserProvider =
    FutureProvider<ResponsePage<Request>>(
  (FutureProviderRef<ResponsePage<Request>> ref) async {
    final Api api = ref.read(apiProvider);
    final Account? authenticatedUser =
        ref.watch(authenticatedUserProvider).valueOrNull;

    if (authenticatedUser == null) {
      throw Exception('User is not authenticated.');
    }

    return api.accounts.getRequests(authenticatedUser.id!);
  },
);

FutureProviderFamily<ResponsePage<Request>, Building>
    requestsOfBuildingProvider = FutureProvider.family(
  (FutureProviderRef<Object?> ref, Building building) async {
    final Api api = ref.read(apiProvider);

    return api.buildings.getRequestsOfBuilding(building);
  },
);
