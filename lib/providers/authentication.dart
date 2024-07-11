import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../models/account.dart';
import '../models/oauth2_response.dart';
import 'api.dart';

FutureProvider<Account?> authenticatedUserProvider =
    FutureProvider<Account?>((FutureProviderRef<Account?> ref) async {
  final Api api = ref.read(apiProvider);
  final OAuth2Response? auth = await api.getAuthorization();

  if (auth == null) {
    return null;
  }

  return api.accounts.getById(auth.decodedAccessToken!.sub);
});
