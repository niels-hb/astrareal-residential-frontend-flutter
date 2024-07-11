import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../models/account.dart';
import '../models/building.dart';
import '../models/response_page.dart';
import '../models/unit.dart';
import 'api.dart';
import 'authentication.dart';

final FutureProvider<ResponsePage<Unit>> ownedUnitsProvider =
    FutureProvider<ResponsePage<Unit>>((FutureProviderRef<Object?> ref) async {
  final Api api = ref.read(apiProvider);
  final Account? authenticatedUser =
      ref.watch(authenticatedUserProvider).valueOrNull;

  if (authenticatedUser == null) {
    throw Exception('User is not authenticated.');
  }

  return api.accounts.getOwnedUnits(authenticatedUser.id!);
});

final FutureProviderFamily<ResponsePage<Unit>, Building> unitsProvider =
    FutureProvider.family<ResponsePage<Unit>, Building>(
        (FutureProviderRef<Object?> ref, Building building) async {
  final Api api = ref.read(apiProvider);

  return api.buildings.getUnitsOfBuilding(building);
});

final FutureProviderFamily<Unit, String> unitProvider =
    FutureProvider.family((FutureProviderRef<Object?> ref, String id) {
  final Api api = ref.read(apiProvider);

  return api.units.getById(id);
});
