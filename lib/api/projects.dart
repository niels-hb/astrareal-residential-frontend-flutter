import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/building.dart';
import '../models/project.dart';
import '../models/response_page.dart';
import '../providers/projects.dart';
import 'api.dart';
import 'http_method.dart';

class ProjectsApi {
  ProjectsApi(this.api);

  final Api api;

  static const String base = '/projects';

  static Project _converter(Map<String, dynamic> json) =>
      Project.fromJson(json);

  Future<ResponsePage<Project>> get() => api.doPagedRequest(
        HttpMethod.GET,
        base,
        converter: _converter,
      );

  Future<ResponsePage<Building>> getBuildingsOfProject(Project project) =>
      api.doPagedRequest(
        HttpMethod.GET,
        '$base/${project.id}/buildings',
        converter: (Map<String, dynamic> json) => Building.fromJson(json),
      );

  Future<Project> create(Project project) => api.doRequest(
        HttpMethod.POST,
        base,
        data: project.toJson(),
        converter: _converter,
        providerInvalidations: (Project project) => <ProviderOrFamily>[
          projectsProvider,
        ],
      );

  Future<Project> getById(String id) => api.doRequest(
        HttpMethod.GET,
        '$base/$id',
        converter: _converter,
      );
}
