import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/api.dart';
import '../../brandings/branding.dart';
import '../../models/account.dart';
import '../../models/address.dart';
import '../../providers/api.dart';
import '../../util/validator.dart';
import '../../widgets/address_selector_form_field.dart';
import '../../widgets/loading_button.dart';

class CompanySignUpPage extends ConsumerWidget {
  CompanySignUpPage({
    super.key,
    required this.account,
  });

  final Account account;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _companyIdController = TextEditingController();
  final TextEditingController _taxIdController = TextEditingController();
  final ValueNotifier<Address?> _address = ValueNotifier<Address?>(null);

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
                              .companySignUpGreeting(account.name),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: _companyIdController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.companyIdNumber,
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
                        TextFormField(
                          controller: _taxIdController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.taxIdNumber,
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
                          notifier: _address,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.registeredAddress,
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
                        SizedBox(
                          width: double.infinity,
                          child: LoadingButton<void>(
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                final Api api = ref.read(apiProvider);

                                await api.accounts.createCompany(
                                  account.copyWith(
                                    idNumber: _companyIdController.text,
                                    taxIdNumber: _taxIdController.text,
                                    registeredAddress: _address.value,
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
