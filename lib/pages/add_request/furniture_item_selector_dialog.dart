import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/furniture_item.dart';
import '../../util/validator.dart';

class FurnitureItemSelectorDialog extends AlertDialog {
  FurnitureItemSelectorDialog({super.key});

  final GlobalKey<FormState> _formState = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _depthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addItem),
      content: SingleChildScrollView(
        child: Form(
          key: _formState,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      controller: _nameController,
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.requiredFieldValidator(value),
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.itemName,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: _quantityController,
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.positiveNumber(value),
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.quantityShort,
                        hintText: AppLocalizations.of(context)!.quantityHint,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: _widthController,
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.positiveNumber(value),
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.widthShort,
                        hintText: AppLocalizations.of(context)!.widthHint,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: _heightController,
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.positiveNumber(value),
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.heightShort,
                        hintText: AppLocalizations.of(context)!.heightHint,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: _depthController,
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.positiveNumber(value),
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.depthShort,
                        hintText: AppLocalizations.of(context)!.depthHint,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel.toUpperCase()),
        ),
        TextButton(
          onPressed: () {
            if (_formState.currentState?.validate() ?? false) {
              final FurnitureItem result = FurnitureItem(
                name: _nameController.text,
                quantity: int.parse(_quantityController.text),
                width: int.parse(_widthController.text),
                height: int.parse(_heightController.text),
                depth: int.parse(_depthController.text),
              );

              Navigator.of(context).pop(result);

              _formState.currentState!.reset();
            }
          },
          child: Text(AppLocalizations.of(context)!.add.toUpperCase()),
        ),
      ],
    );
  }
}
