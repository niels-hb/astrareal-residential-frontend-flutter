import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../models/password_change_request.dart';
import '../../../../util/validator.dart';
import '../../../../widgets/custom_app_bar.dart';

class EditPasswordPage extends StatelessWidget {
  EditPasswordPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.editPassword,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop(
                  PasswordChangeRequest(
                    currentPassword: _currentPasswordController.text,
                    newPassword: _newPasswordController.text,
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _currentPasswordController,
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) =>
                      v.passwordValidator(value),
                ),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.currentPassword,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _newPasswordController,
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) =>
                      v.passwordValidator(value),
                ),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.newPassword,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _confirmNewPasswordController,
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) =>
                      v.passwordConfirmationValidator(
                    _newPasswordController.text,
                    value,
                  ),
                ),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.confirmPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
