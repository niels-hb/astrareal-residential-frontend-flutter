import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/access_card.dart';
import '../../models/account_type.dart';
import '../../models/gender.dart';
import '../../models/nationality.dart';
import '../../models/unit.dart';
import '../../providers/api.dart';
import '../../providers/units.dart';
import '../../util/validator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_data_row.dart';
import '../../widgets/single_form_field_selector_page.dart';

class UnitPage extends ConsumerWidget {
  const UnitPage({
    super.key,
    required this.unit,
  });

  final Unit unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Unit unit =
        ref.watch(unitProvider(this.unit.id!)).valueOrNull ?? this.unit;

    return Scaffold(
      appBar: CustomAppBar(
        title: unit.name,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.unitInformation,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.id,
                  text: unit.id.toString(),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.unitNumber,
                  text: unit.name,
                  onEdit: () async {
                    final String? name = await Navigator.of(context).push(
                      MaterialPageRoute<String>(
                        builder: (BuildContext context) =>
                            SingleFormFieldSelectorPage(
                          title: AppLocalizations.of(context)!.editUnitNumber,
                          initial: unit.name,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.unitNumber,
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
                      ref.read(apiProvider).units.setName(unit, name);
                    }
                  },
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.access_cards,
                  text: unit.accessCards.isEmpty
                      ? '-'
                      : unit.accessCards
                          .map(
                              (AccessCard e) => '${e.number} (${e.owner.name})')
                          .join('\n'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.ownerInformation,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.id,
                  text: unit.owner.id.toString(),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.name,
                  text: unit.owner.name,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.email,
                  text: unit.owner.email,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.telephone_number,
                  text: unit.owner.telephoneNumber,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.user_type,
                  text: unit.owner.type.translate(context),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.nationality,
                  text: unit.owner.nationality?.translate(context) ?? '-',
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.dateOfBirth,
                  text: unit.owner.dateOfBirth == null
                      ? '-'
                      : DateFormat.yMd().format(unit.owner.dateOfBirth!),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.gender,
                  text: unit.owner.gender?.translate(context) ?? '-',
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label:
                      AppLocalizations.of(context)!.permanentResidentialAddress,
                  text: unit.owner.permanentResidentialAddress
                          ?.translate(context) ??
                      '-',
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.identification,
                  text: unit.owner.identification?.translate(context) ?? '-',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  text: unit.building.id.toString(),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.name,
                  text: unit.building.name,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.address,
                  text: unit.building.address.translate(context),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.office,
                  text: unit.building.telephoneNumberOffice ?? '-',
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.reception,
                  text: unit.building.telephoneNumberReception ?? '-',
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.security,
                  text: unit.building.telephoneNumberSecurity ?? '-',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.projectInformation,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.id,
                  text: unit.building.project.id.toString(),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.name,
                  text: unit.building.project.name,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
