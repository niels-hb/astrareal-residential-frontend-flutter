import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../models/project.dart';
import '../models/response_page.dart';
import 'api.dart';

final FutureProvider<ResponsePage<Project>> projectsProvider =
    FutureProvider<ResponsePage<Project>>(
        (FutureProviderRef<ResponsePage<Project>> ref) {
  final Api api = ref.read(apiProvider);

  return api.projects.get();
});

final FutureProviderFamily<Project, String> projectProvider =
    FutureProvider.family((FutureProviderRef<Object?> ref, String id) {
  final Api api = ref.read(apiProvider);

  return api.projects.getById(id);
});
