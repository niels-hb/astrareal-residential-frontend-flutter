import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../models/account.dart';
import '../models/lease.dart';
import '../models/response_page.dart';
import 'api.dart';
import 'authentication.dart';

final FutureProvider<ResponsePage<Lease>> leasesProvider = _leasesProvider;

final FutureProvider<ResponsePage<Lease>> _leasesProvider =
    FutureProvider<ResponsePage<Lease>>((
  FutureProviderRef<ResponsePage<Lease>> ref,
) async {
  final Api api = ref.read(apiProvider);
  final Account? authenticatedUser =
      ref.watch(authenticatedUserProvider).valueOrNull;

  if (authenticatedUser == null) {
    throw Exception('User is not authenticated.');
  }

  return api.accounts.getLeases(authenticatedUser.id!);
});
