import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/project.dart';
import '../../../models/response_page.dart';
import '../../../providers/projects.dart';
import '../../project/page.dart';

class ProjectsTab extends ConsumerWidget {
  const ProjectsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ResponsePage<Project>> projects =
        ref.watch(projectsProvider);

    return projects.when(
      data: (ResponsePage<Project> projects) {
        if (projects.totalElements == 0) {
          return Center(
            child: Text(AppLocalizations.of(context)!.emptyProjects),
          );
        }

        return ListView.builder(
          itemCount: projects.totalElements,
          itemBuilder: (BuildContext context, int i) {
            final Project project = projects.content[i];

            return ListTile(
              title: Text(project.name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ProjectPage(
                      project: project,
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
    );
  }
}
