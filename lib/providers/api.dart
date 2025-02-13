import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';

Provider<Api> apiProvider = Provider<Api>(
  (ProviderRef<Api> ref) => Api(ref),
);
