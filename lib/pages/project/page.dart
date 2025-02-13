import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/building.dart';
import '../../models/project.dart';
import '../../models/response_page.dart';
import '../../providers/buildings.dart';
import '../../providers/projects.dart';
import '../../widgets/custom_app_bar.dart';
import '../add_building/page.dart';
import '../building/page.dart';

class ProjectPage extends ConsumerWidget {
  const ProjectPage({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Project project =
        ref.watch(projectProvider(this.project.id!)).valueOrNull ??
            this.project;
    final AsyncValue<ResponsePage<Building>> buildings =
        ref.watch(buildingsProvider(project));

    return Scaffold(
      appBar: CustomAppBar(
        title: project.name,
      ),
      body: buildings.when(
        data: (ResponsePage<Building> buildings) {
          if (buildings.totalElements == 0) {
            return Center(
              child: Text(AppLocalizations.of(context)!.emptyBuildings),
            );
          }

          return ListView.builder(
            itemCount: buildings.totalElements,
            itemBuilder: (BuildContext context, int i) {
              final Building building = buildings.content[i];

              return ListTile(
                title: Text(building.name),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => BuildingPage(
                        building: building,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        error: (Object e, StackTrace stackTrace) => Center(
          child: Text(e.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddBuildingPage(
                project: project,
              ),
            ),
          );
        },
      ),
    );
  }
}
