import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/furniture_item.dart';
import '../../models/furniture_request.dart';
import '../../models/furniture_requirements.dart';
import '../../models/lease.dart';
import '../../models/request_type.dart';
import '../../models/response_page.dart';
import '../../models/unit.dart';
import '../../providers/api.dart';
import '../../providers/leases.dart';
import '../../util/time.dart';
import '../../util/validator.dart';
import '../../widgets/date_picker_form_field.dart';
import '../../widgets/loading_button.dart';
import '../../widgets/time_picker_form_field.dart';
import 'furniture_item_selector_dialog.dart';
import 'furniture_requirements_selector.dart';
import 'item_selector.dart';

class FurnitureForm extends ConsumerWidget {
  FurnitureForm({
    required this.type,
    super.key,
  });

  final RequestType type;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<Unit?> _unit = ValueNotifier<Unit?>(null);
  final ValueNotifier<List<FurnitureItem>> _items =
      ValueNotifier<List<FurnitureItem>>(<FurnitureItem>[]);
  final ValueNotifier<DateTime?> _movingDate = ValueNotifier<DateTime?>(null);
  final ValueNotifier<TimeOfDay?> _movingTimeFrom =
      ValueNotifier<TimeOfDay?>(null);
  final ValueNotifier<TimeOfDay?> _movingTimeTo =
      ValueNotifier<TimeOfDay?>(null);
  final ValueNotifier<Set<FurnitureRequirements>> _requirements =
      ValueNotifier<Set<FurnitureRequirements>>(<FurnitureRequirements>{});
  final ValueNotifier<String?> _otherRequirements =
      ValueNotifier<String?>(null);
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ResponsePage<Lease>> leases = ref.watch(leasesProvider);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          leases.when(
            loading: () => DropdownButtonFormField<void>(
              items: const <DropdownMenuItem<void>>[],
              onChanged: (_) {},
            ),
            data: (ResponsePage<Lease> data) => DropdownButtonFormField<Unit>(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.unit,
              ),
              validator: (Unit? value) {
                if (value == null) {
                  return AppLocalizations.of(context)!.requiredFieldMissing;
                }

                return null;
              },
              items: data.content
                  .map(
                    (Lease e) => DropdownMenuItem<Unit>(
                      value: e.unit,
                      child: Text(e.unit.name),
                    ),
                  )
                  .toList(),
              onChanged: (Unit? unit) {
                _unit.value = unit;
              },
            ),
            error: (Object error, StackTrace stackTrace) =>
                Text(error.toString()),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ItemSelectorFormField<FurnitureItem>(
            title: AppLocalizations.of(context)!.items,
            addItemDialog: FurnitureItemSelectorDialog(),
            validator: (List<FurnitureItem>? value) =>
                Validator.of(context).getErrorMessage(
              validationResults: (Validator v) =>
                  v.requiredListValidator(value),
            ),
            itemConverter: (FurnitureItem item) => Text(
              AppLocalizations.of(context)!.furnitureItem(
                item.quantity,
                item.name,
                item.width,
                item.height,
                item.depth,
              ),
            ),
            onChanged: (List<FurnitureItem> items) {
              _items.value = items;
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            AppLocalizations.of(context)!.movingTime,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          DatePickerFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.movingDate,
            ),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              const Duration(days: 30),
            ),
            notifier: _movingDate,
            validator: (String? value) => Validator.of(context).getErrorMessage(
              validationResults: (Validator v) =>
                  v.requiredFieldValidator(value),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: TimePickerFormField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.movingTimeFrom),
                  notifier: _movingTimeFrom,
                  validator: (String? value) =>
                      Validator.of(context).getErrorMessage(
                    validationResults: (Validator v) =>
                        v.requiredFieldValidator(value),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(AppLocalizations.of(context)!.to),
              const SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: TimePickerFormField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.movingTimeTo),
                  notifier: _movingTimeTo,
                  validator: (String? value) =>
                      Validator.of(context).getErrorMessage(
                    validationResults: (Validator v) =>
                        v.requiredFieldValidator(value),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          FurnitureRequirementsSelector(
            onChanged: (Set<FurnitureRequirements> selected, String other) {
              _requirements.value = selected;
              _otherRequirements.value = other;
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            AppLocalizations.of(context)!.notes,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: _notesController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.notes,
            ),
            maxLines: 3,
          ),
          const SizedBox(
            height: 8.0,
          ),
          SizedBox(
            width: double.infinity,
            child: LoadingButton<void>(
              child: Text(AppLocalizations.of(context)!.submit),
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final FurnitureRequest request = FurnitureRequest(
                    type: type,
                    unit: _unit.value!,
                    items: _items.value,
                    movingDate: _movingDate.value!,
                    movingTimeFrom: _movingTimeFrom.value!.toDateTime(),
                    movingTimeTo: _movingTimeTo.value!.toDateTime(),
                    requirements: _requirements.value.toList(),
                    otherRequirements: _otherRequirements.value,
                    notes: _notesController.text,
                    denied: false,
                  );

                  await ref
                      .read(apiProvider)
                      .requests
                      .createFurnitureRequest(request);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
