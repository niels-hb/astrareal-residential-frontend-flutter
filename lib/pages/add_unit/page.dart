import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../models/account_email.dart';
import '../../models/building.dart';
import '../../models/create_unit_request.dart';
import '../../providers/api.dart';
import '../../util/validator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_button.dart';

class AddUnitPage extends ConsumerWidget {
  AddUnitPage({
    super.key,
    required this.building,
  });

  final Building building;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.addUnit,
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.unitNumber,
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
                controller: _ownerController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.ownerEmail,
                ),
                validator: (String? value) =>
                    Validator.of(context).getErrorMessage(
                  validationResults: (Validator v) => v.emailValidator(value),
                ),
                keyboardType: TextInputType.emailAddress,
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

                      try {
                        await api.units.create(CreateUnitRequest(
                          building: building,
                          name: _nameController.text,
                          owner: AccountEmail(
                            email: _ownerController.text,
                          ),
                        ));

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } on DioException catch (e) {
                        if (e.response?.statusCode == 404) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!
                                    .ownerEmailNotFound,
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
