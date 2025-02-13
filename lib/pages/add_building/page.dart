import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../models/address.dart';
import '../../models/building.dart';
import '../../models/project.dart';
import '../../providers/api.dart';
import '../../util/validator.dart';
import '../../widgets/address_selector_form_field.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_button.dart';

class AddBuildingPage extends ConsumerWidget {
  AddBuildingPage({
    super.key,
    required this.project,
  });

  final Project project;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<Address?> _address = ValueNotifier<Address?>(null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.addBuilding,
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name,
                ),
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) =>
                      v.requiredFieldValidator(value),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              AddressSelectorFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.address,
                ),
                notifier: _address,
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) => v.requiredFieldValidator(
                    value,
                    ValidationResult.addressMissing,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: double.infinity,
                child: LoadingButton<void>(
                  child: Text(
                    AppLocalizations.of(context)!.submit.toUpperCase(),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final Api api = ref.read(apiProvider);

                      await api.buildings.create(Building(
                        name: _nameController.text,
                        address: _address.value!,
                        project: project,
                      ));

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
