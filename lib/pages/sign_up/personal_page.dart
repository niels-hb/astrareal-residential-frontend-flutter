import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../api/api.dart';
import '../../brandings/branding.dart';
import '../../models/account.dart';
import '../../models/address.dart';
import '../../models/gender.dart';
import '../../models/identification.dart';
import '../../models/nationality.dart';
import '../../providers/api.dart';
import '../../util/validator.dart';
import '../../widgets/address_selector_form_field.dart';
import '../../widgets/date_picker_form_field.dart';
import '../../widgets/loading_button.dart';
import 'identification_selector_page.dart';

class PersonalSignUpPage extends ConsumerWidget {
  PersonalSignUpPage({
    super.key,
    required this.account,
  });

  final Account account;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ValueNotifier<DateTime?> _dateOfBirth = ValueNotifier<DateTime?>(null);
  final TextEditingController _nationalityController = TextEditingController();
  final ValueNotifier<Address?> _address = ValueNotifier<Address?>(null);
  final ValueNotifier<Gender?> _gender = ValueNotifier<Gender?>(null);
  final ValueNotifier<Identification?> _identification =
      ValueNotifier<Identification?>(null);
  final TextEditingController _identificationController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 250.0,
                          child: Hero(
                            tag: Branding.of(context).logo,
                            child: Image.asset(Branding.of(context).logo),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .personalSignUpGreeting(account.name),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        DatePickerFormField(
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.dateOfBirth,
                          ),
                          notifier: _dateOfBirth,
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.requiredFieldValidator(
                              value,
                              ValidationResult.dateOfBirthMissing,
                            ),
                          ),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TypeAheadFormField<Nationality>(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _nationalityController,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.nationality,
                            ),
                          ),
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.nationalityValidator(value),
                          ),
                          onSuggestionSelected: (Nationality suggestion) {
                            _nationalityController.text =
                                suggestion.translate(context);
                          },
                          itemBuilder: (
                            BuildContext context,
                            Nationality itemData,
                          ) =>
                              ListTile(
                            title: Text(
                              itemData.translate(context),
                            ),
                          ),
                          suggestionsCallback: (String pattern) =>
                              Nationality.values.where(
                            (Nationality element) => element
                                .translate(context)
                                .toLowerCase()
                                .contains(pattern.toLowerCase()),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        AddressSelectorFormField(
                          notifier: _address,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .permanentResidentialAddress,
                          ),
                          validator: (String? value) => Validator.of(context)
                              .getErrorMessage(
                                  validationResults: (Validator v) =>
                                      v.requiredFieldValidator(
                                        value,
                                        ValidationResult.addressMissing,
                                      )),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        DropdownButtonFormField<Gender>(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.gender,
                          ),
                          validator: (Gender? value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!
                                  .genderRequired;
                            }

                            return null;
                          },
                          items: Gender.values
                              .map(
                                (Gender e) => DropdownMenuItem<Gender>(
                                  value: e,
                                  child: Text(e.translate(context)),
                                ),
                              )
                              .toList(),
                          onChanged: (Gender? value) {
                            _gender.value = value;
                          },
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _identificationController,
                          readOnly: true,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.identification,
                          ),
                          validator: (String? value) => Validator.of(context)
                              .getErrorMessage(
                                  validationResults: (Validator v) =>
                                      v.requiredFieldValidator(
                                        value,
                                        ValidationResult.identificationMissing,
                                      )),
                          onTap: () async {
                            final Identification? identification =
                                await Navigator.of(context)
                                    .push<Identification?>(
                              MaterialPageRoute<Identification?>(
                                builder: (BuildContext context) =>
                                    IdentificationSelectorPage(
                                  initial: _identification.value,
                                ),
                              ),
                            );

                            if (identification != null) {
                              _identification.value = identification;
                              if (context.mounted) {
                                _identificationController.text =
                                    '${identification.idNumber} / ${identification.fullName}';
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: LoadingButton<void>(
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                final Api api = ref.read(apiProvider);

                                await api.accounts.createPersonal(
                                  account.copyWith(
                                    dateOfBirth: _dateOfBirth.value,
                                    nationality: nationalityFromTranslation(
                                      context,
                                      _nationalityController.text,
                                    ),
                                    permanentResidentialAddress: _address.value,
                                    gender: _gender.value,
                                    identification: _identification.value,
                                  ),
                                );

                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .signUp
                                  .toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
