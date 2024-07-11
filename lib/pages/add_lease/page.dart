import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../models/account.dart';
import '../../models/account_email.dart';
import '../../models/create_lease_request.dart';
import '../../models/response_page.dart';
import '../../models/unit.dart';
import '../../providers/api.dart';
import '../../providers/authentication.dart';
import '../../providers/units.dart';
import '../../util/currency_input_formatter.dart';
import '../../util/validator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/date_picker_form_field.dart';
import '../../widgets/loading_button.dart';

class AddLeasePage extends ConsumerWidget {
  AddLeasePage({super.key});

  static const String route = '/add_lease';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<Unit?> _unitNotifier = ValueNotifier<Unit?>(null);
  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<DateTime> _startDateNotifier =
      ValueNotifier<DateTime>(DateTime.now());
  final ValueNotifier<DateTime> _endDateNotifier =
      ValueNotifier<DateTime>(DateTime.now());
  final TextEditingController _rentalFeeController = TextEditingController();
  final TextEditingController _leaseTermsController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Account?> authenticatedUser =
        ref.watch(authenticatedUserProvider);
    final AsyncValue<ResponsePage<Unit>> ownedUnits =
        ref.watch(ownedUnitsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.addLease,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(32.0),
            color: Theme.of(context).cardColor,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.addLease,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  DropdownButtonFormField<Unit>(
                    items: ownedUnits.when(
                      data: (ResponsePage<Unit> data) => data.content
                          .map(
                            (Unit e) => DropdownMenuItem<Unit>(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      error: (Object e, StackTrace stackTrace) =>
                          <DropdownMenuItem<Unit>>[],
                      loading: () => <DropdownMenuItem<Unit>>[],
                    ),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.unit,
                    ),
                    onChanged: (Unit? selected) {
                      _unitNotifier.value = selected;
                    },
                    validator: (Unit? value) {
                      if (value == null) {
                        return AppLocalizations.of(context)!
                            .requiredFieldMissing;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    AppLocalizations.of(context)!.lessee_information,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.email,
                    ),
                    validator: (String? value) =>
                        Validator.of(context).getErrorMessage(
                      validationResults: (Validator v) =>
                          v.emailValidator(value),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    AppLocalizations.of(context)!.leaseInformation,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: DatePickerFormField(
                          notifier: _startDateNotifier,
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.requiredFieldValidator(value),
                          ),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.leaseStart,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: DatePickerFormField(
                          notifier: _endDateNotifier,
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.requiredFieldValidator(value),
                          ),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.leaseEnd,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _rentalFeeController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    validator: (String? value) =>
                        Validator.of(context).getErrorMessage(
                      validationResults: (Validator v) => <ValidationResult>[
                        ...v.requiredFieldValidator(value),
                      ],
                    ),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.rentalFee,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _leaseTermsController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.lease_terms,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: LoadingButton<void>(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final Api api = ref.read(apiProvider);

                          try {
                            await api.leases.create(
                              CreateLeaseRequest(
                                lessor: authenticatedUser.value!,
                                lessee: AccountEmail(
                                  email: _emailController.text,
                                ),
                                leaseStart: _startDateNotifier.value,
                                leaseEnd: _endDateNotifier.value,
                                rentalFee: int.tryParse(_rentalFeeController
                                        .text
                                        .replaceAll(RegExp('[^0-9]'), '')) ??
                                    0,
                                leaseTerms: _leaseTermsController.text,
                                unit: _unitNotifier.value!,
                              ),
                            );

                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          } on DioException catch (e) {
                            if (e.response?.statusCode == 404) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .lesseeEmailNotFound,
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.submit,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
