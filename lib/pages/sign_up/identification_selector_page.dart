import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/identification.dart';
import '../../models/identification_type.dart';
import '../../util/validator.dart';
import '../../widgets/custom_app_bar.dart';

class IdentificationSelectorPage extends StatefulWidget {
  const IdentificationSelectorPage({
    super.key,
    this.initial,
  });

  final Identification? initial;

  @override
  State<IdentificationSelectorPage> createState() =>
      _IdentificationSelectorPageState();
}

class _IdentificationSelectorPageState
    extends State<IdentificationSelectorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<IdentificationType?> _typeController =
      ValueNotifier<IdentificationType?>(null);
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.initial != null) {
      _typeController.value = widget.initial!.type;
      _idNumberController.text = widget.initial!.idNumber;
      _fullNameController.text = widget.initial!.fullName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.editIdentification,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop(
                  Identification(
                    type: _typeController.value!,
                    idNumber: _idNumberController.text,
                    fullName: _fullNameController.text,
                  ),
                );
              }
            },
          ),
        ],
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
              DropdownButtonFormField<IdentificationType>(
                value: _typeController.value,
                items: IdentificationType.values
                    .map(
                      (IdentificationType e) =>
                          DropdownMenuItem<IdentificationType>(
                        value: e,
                        child: Text(e.translate(context)),
                      ),
                    )
                    .toList(),
                validator: (IdentificationType? value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.requiredFieldMissing;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.identificationType,
                ),
                onChanged: (IdentificationType? value) {
                  _typeController.value = value;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: _idNumberController,
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) =>
                      v.requiredFieldValidator(value),
                ),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.idNumber,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: _fullNameController,
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) =>
                      v.requiredFieldValidator(value),
                ),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.fullName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
