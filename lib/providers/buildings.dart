import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../models/building.dart';
import '../models/project.dart';
import '../models/response_page.dart';
import 'api.dart';

final FutureProviderFamily<ResponsePage<Building>, Project> buildingsProvider =
    FutureProvider.family((FutureProviderRef<Object?> ref, Project project) {
  final Api api = ref.read(apiProvider);

  return api.projects.getBuildingsOfProject(project);
});

final FutureProviderFamily<Building, String> buildingProvider =
    FutureProvider.family((FutureProviderRef<Object?> ref, String id) {
  final Api api = ref.read(apiProvider);

  return api.buildings.getById(id);
});
