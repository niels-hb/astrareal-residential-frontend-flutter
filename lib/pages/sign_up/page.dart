import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../brandings/branding.dart';
import '../../models/account.dart';
import '../../models/account_type.dart';
import '../../util/validator.dart';
import '../../widgets/horizontal_selector.dart';
import 'company_page.dart';
import 'personal_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  static const String route = '/sign_up';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ValueNotifier<AccountType> _accountTypeController =
      ValueNotifier<AccountType>(AccountType.individual);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
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
                    HorizontalSelector<AccountType>(
                      controller: _accountTypeController,
                      values: <HorizontalSelectorItem<AccountType>>[
                        HorizontalSelectorItem<AccountType>(
                          AppLocalizations.of(context)!.individual,
                          AccountType.individual,
                        ),
                        HorizontalSelectorItem<AccountType>(
                          AppLocalizations.of(context)!.company,
                          AccountType.company,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.badge),
                        labelText: AppLocalizations.of(context)!.name,
                      ),
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.requiredFieldValidator(
                          value,
                          ValidationResult.nameMissing,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        labelText: AppLocalizations.of(context)!.email,
                      ),
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.emailValidator(value),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _telephoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        labelText:
                            AppLocalizations.of(context)!.telephone_number,
                      ),
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.telephoneNumberValidator(value),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        labelText: AppLocalizations.of(context)!.password,
                      ),
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.passwordValidator(value),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _passwordConfirmationController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        labelText:
                            AppLocalizations.of(context)!.confirmPassword,
                      ),
                      validator: (String? value) =>
                          Validator.of(context).getErrorMessage(
                        validationResults: (Validator v) =>
                            v.passwordConfirmationValidator(
                          _passwordController.text,
                          value,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            _navigateToNextPage(context);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUp.toUpperCase(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context) {
    final Account account = Account(
      name: _nameController.text,
      email: _emailController.text,
      telephoneNumber: _telephoneNumberController.text,
      type: _accountTypeController.value,
      password: _passwordController.text,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          switch (_accountTypeController.value) {
            case AccountType.individual:
              return PersonalSignUpPage(
                account: account,
              );
            case AccountType.company:
              return CompanySignUpPage(
                account: account,
              );
          }
        },
      ),
    );
  }
}
