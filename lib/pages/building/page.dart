import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/address.dart';
import '../../models/building.dart';
import '../../models/request.dart';
import '../../models/response_page.dart';
import '../../models/unit.dart';
import '../../providers/api.dart';
import '../../providers/buildings.dart';
import '../../providers/requests.dart';
import '../../providers/units.dart';
import '../../util/validator.dart';
import '../../widgets/address_selector_page.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_data_row.dart';
import '../../widgets/request_card.dart';
import '../../widgets/single_form_field_selector_page.dart';
import '../add_unit/page.dart';
import '../unit/page.dart';

enum _BuildingPageTab {
  units,
  requests,
}

StateProvider<_BuildingPageTab> _selectedTabProvider =
    StateProvider<_BuildingPageTab>(
        (StateProviderRef<_BuildingPageTab> ref) => _BuildingPageTab.units);

class BuildingPage extends ConsumerWidget {
  const BuildingPage({
    super.key,
    required this.building,
  });

  final Building building;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Building building =
        ref.watch(buildingProvider(this.building.id!)).valueOrNull ??
            this.building;
    final AsyncValue<ResponsePage<Unit>> units =
        ref.watch(unitsProvider(building));
    final AsyncValue<ResponsePage<Request>> requests =
        ref.watch(requestsOfBuildingProvider(building));
    final _BuildingPageTab selectedTab = ref.watch(_selectedTabProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: building.name,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.buildingInformation,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.id,
                  text: building.id.toString(),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.name,
                  text: building.name,
                  onEdit: () async {
                    final String? name = await Navigator.of(context).push(
                      MaterialPageRoute<String>(
                        builder: (BuildContext context) =>
                            SingleFormFieldSelectorPage(
                          title: AppLocalizations.of(context)!.editName,
                          initial: building.name,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.name,
                          ),
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.requiredFieldValidator(value),
                          ),
                        ),
                      ),
                    );

                    if (name != null) {
                      ref.read(apiProvider).buildings.setName(building, name);
                    }
                  },
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.address,
                  text: building.address.translate(context),
                  onEdit: () async {
                    final Address? address = await Navigator.of(context).push(
                      MaterialPageRoute<Address>(
                        builder: (BuildContext context) => AddressSelectorPage(
                          initial: building.address,
                        ),
                      ),
                    );

                    if (address != null) {
                      ref
                          .read(apiProvider)
                          .buildings
                          .setAddress(building, address);
                    }
                  },
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.office,
                  text: building.telephoneNumberOffice ?? '-',
                  onEdit: () async {
                    final String? telephoneNumber =
                        await Navigator.of(context).push(
                      MaterialPageRoute<String>(
                        builder: (BuildContext context) =>
                            SingleFormFieldSelectorPage(
                          title:
                              AppLocalizations.of(context)!.editTelephoneNumber,
                          initial: building.telephoneNumberOffice,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.telephone_number,
                          ),
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.telephoneNumberValidator(
                              value,
                              required: false,
                            ),
                          ),
                        ),
                      ),
                    );

                    ref
                        .read(apiProvider)
                        .buildings
                        .setTelephoneNumberOffice(building, telephoneNumber);
                  },
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.reception,
                  text: building.telephoneNumberReception ?? '-',
                  onEdit: () async {
                    final String? telephoneNumber =
                        await Navigator.of(context).push(
                      MaterialPageRoute<String>(
                        builder: (BuildContext context) =>
                            SingleFormFieldSelectorPage(
                          title:
                              AppLocalizations.of(context)!.editTelephoneNumber,
                          initial: building.telephoneNumberReception,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.telephone_number,
                          ),
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.telephoneNumberValidator(
                              value,
                              required: false,
                            ),
                          ),
                        ),
                      ),
                    );

                    ref
                        .read(apiProvider)
                        .buildings
                        .setTelephoneNumberReception(building, telephoneNumber);
                  },
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.security,
                  text: building.telephoneNumberSecurity ?? '-',
                  onEdit: () async {
                    final String? telephoneNumber =
                        await Navigator.of(context).push(
                      MaterialPageRoute<String>(
                        builder: (BuildContext context) =>
                            SingleFormFieldSelectorPage(
                          title:
                              AppLocalizations.of(context)!.editTelephoneNumber,
                          initial: building.telephoneNumberSecurity,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.telephone_number,
                          ),
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.telephoneNumberValidator(
                              value,
                              required: false,
                            ),
                          ),
                        ),
                      ),
                    );

                    ref
                        .read(apiProvider)
                        .buildings
                        .setTelephoneNumberSecurity(building, telephoneNumber);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ColoredBox(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          ref.read(_selectedTabProvider.notifier).state =
                              _BuildingPageTab.units;
                        },
                        child: Text(
                          AppLocalizations.of(context)!.units,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    decoration:
                                        selectedTab == _BuildingPageTab.units
                                            ? TextDecoration.underline
                                            : null,
                                  ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(_selectedTabProvider.notifier).state =
                              _BuildingPageTab.requests;
                        },
                        child: Text(
                          AppLocalizations.of(context)!.requests,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    decoration:
                                        selectedTab == _BuildingPageTab.requests
                                            ? TextDecoration.underline
                                            : null,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (selectedTab == _BuildingPageTab.units)
                  units.when(
                    data: (ResponsePage<Unit> units) {
                      if (units.totalElements == 0) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              AppLocalizations.of(context)!.emptyUnits,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: units.totalElements,
                        itemBuilder: (BuildContext context, int i) {
                          final Unit unit = units.content[i];

                          return ListTile(
                            title: Text(unit.name),
                            subtitle: Text(unit.owner.name),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => UnitPage(
                                    unit: unit,
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
                if (selectedTab == _BuildingPageTab.requests)
                  requests.when(
                    data: (ResponsePage<Request> requests) {
                      final List<Request> filteredRequsts = requests.content
                          .where(
                              (Request r) => r.approvedBy != null && !r.denied)
                          .toList();

                      if (filteredRequsts.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              AppLocalizations.of(context)!.emptyRequests,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredRequsts.length,
                        itemBuilder: (BuildContext context, int i) =>
                            RequestCard(
                          request: filteredRequsts[i],
                        ),
                      );
                    },
                    error: (Object e, StackTrace stackTrace) => Center(
                      child: Text(e.toString()),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddUnitPage(
                building: building,
              ),
            ),
          );
        },
      ),
    );
  }
}
