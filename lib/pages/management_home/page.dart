import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../util/tab_definition.dart';
import '../../widgets/custom_app_bar.dart';
import '../add_project/page.dart';
import '../home/tabs/account/tab.dart';
import 'tabs/projects.dart';

class ManagementHomePage extends StatefulWidget {
  const ManagementHomePage({super.key});

  static const String route = '/management_home';

  @override
  State<ManagementHomePage> createState() => _ManagementHomePageState();
}

class _ManagementHomePageState extends State<ManagementHomePage> {
  List<TabDefinition> get _tabs => <TabDefinition>[
        TabDefinition(
          title: AppLocalizations.of(context)!.projects,
          body: const ProjectsTab(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddProjectPage.route);
            },
          ),
        ),
        TabDefinition(
          title: AppLocalizations.of(context)!.my_account,
          body: const AccountTab(),
        ),
      ];

  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _tabs[_currentTab].title,
      ),
      body: _tabs[_currentTab].body,
      floatingActionButton: _tabs[_currentTab].floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.projects,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.account,
          ),
        ],
      ),
    );
  }
}
