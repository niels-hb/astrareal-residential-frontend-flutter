import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../models/address.dart';
import '../models/country.dart';
import '../util/validator.dart';
import 'custom_app_bar.dart';

class AddressSelectorPage extends StatefulWidget {
  const AddressSelectorPage({
    super.key,
    this.initial,
  });

  final Address? initial;

  @override
  State<AddressSelectorPage> createState() => _AddressSelectorPageState();
}

class _AddressSelectorPageState extends State<AddressSelectorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.initial != null) {
      _addressLine1Controller.text = widget.initial!.addressLine1;
      _addressLine2Controller.text = widget.initial!.addressLine2 ?? '';
      _cityController.text = widget.initial!.city;
      _postalCodeController.text = widget.initial!.postalCode;
      _countryController.text = widget.initial!.country.translate(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.editAddress,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop(
                  Address(
                    addressLine1: _addressLine1Controller.text,
                    addressLine2: _addressLine2Controller.text,
                    city: _cityController.text,
                    postalCode: _postalCodeController.text,
                    country: countryFromTranslation(
                      context,
                      _countryController.text,
                    )!,
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
              TextFormField(
                controller: _addressLine1Controller,
                keyboardType: TextInputType.streetAddress,
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) =>
                      v.requiredFieldValidator(value),
                ),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addressLine1,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: _addressLine2Controller,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addressLine2,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.city,
                      ),
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
                  Flexible(
                    child: TextFormField(
                      controller: _postalCodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.postalCode,
                      ),
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
                height: 8.0,
              ),
              TypeAheadFormField<Country>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _countryController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.country,
                  ),
                ),
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) => v.countryValidator(value),
                ),
                suggestionsCallback: (String pattern) => Country.values.where(
                    (Country country) => country
                        .translate(context)
                        .toLowerCase()
                        .contains(pattern.toLowerCase())),
                onSuggestionSelected: (Country suggestion) {
                  _countryController.text = suggestion.translate(context);
                },
                itemBuilder: (BuildContext context, Country itemData) =>
                    ListTile(
                  title: Text(itemData.translate(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
