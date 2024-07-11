import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/response_page.dart';
import '../../models/unit.dart';
import '../../providers/units.dart';
import '../../util/tab_definition.dart';
import '../../widgets/custom_app_bar.dart';
import '../add_lease/page.dart';
import '../add_request/page.dart';
import 'tabs/account/tab.dart';
import 'tabs/lease/tab.dart';
import 'tabs/requests/tab.dart';

final StateProvider<int> _selectedTabProvider =
    StateProvider<int>((StateProviderRef<int> ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const String route = '/home';

  List<TabDefinition> _getTabs(BuildContext context, WidgetRef ref) =>
      <TabDefinition>[
        TabDefinition(
          title: AppLocalizations.of(context)!.my_unit,
          body: const LeaseTab(),
          floatingActionButton: ref.watch(ownedUnitsProvider).when(
                data: (ResponsePage<Unit> data) => data.totalElements > 0
                    ? FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddLeasePage.route);
                        },
                        child: const Icon(Icons.add),
                      )
                    : null,
                error: (Object e, StackTrace stackTrace) => null,
                loading: () => null,
              ),
        ),
        TabDefinition(
          title: AppLocalizations.of(context)!.my_requests,
          body: const RequestsTab(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddRequestPage.route);
            },
            child: const Icon(Icons.add),
          ),
        ),
        TabDefinition(
          title: AppLocalizations.of(context)!.my_account,
          body: const AccountTab(),
        ),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentTab = ref.watch(_selectedTabProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: _getTabs(context, ref)[currentTab].title,
      ),
      body: SafeArea(
        child: _getTabs(context, ref)[currentTab].body,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, ref),
      floatingActionButton:
          _getTabs(context, ref)[currentTab].floatingActionButton,
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(
    BuildContext context,
    WidgetRef ref,
  ) {
    final int currentTab = ref.watch(_selectedTabProvider);

    return BottomNavigationBar(
      currentIndex: currentTab,
      onTap: (int index) {
        ref.read(_selectedTabProvider.notifier).state = index;
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.unit,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.construction),
          label: AppLocalizations.of(context)!.requests,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.badge),
          label: AppLocalizations.of(context)!.account,
        ),
      ],
    );
  }
}
