import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../models/account.dart';
import '../../../../models/account_type.dart';
import '../../../../models/address.dart';
import '../../../../models/gender.dart';
import '../../../../models/nationality.dart';
import '../../../../models/password_change_request.dart';
import '../../../../providers/api.dart';
import '../../../../providers/authentication.dart';
import '../../../../util/validator.dart';
import '../../../../widgets/address_selector_page.dart';
import '../../../../widgets/custom_data_row.dart';
import '../../../../widgets/single_form_field_selector_page.dart';
import '../../../sign_in/page.dart';
import 'edit_password_page.dart';

class AccountTab extends ConsumerWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Account?> account = ref.watch(authenticatedUserProvider);

    return account.when(
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      data: (Account? account) {
        if (account != null) {
          return _buildBody(context, ref, account);
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
      error: (Object error, StackTrace stackTrace) => Center(
        child: Text(
          error.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, Account account) {
    return ListView(
      children: <Widget>[
        ColoredBox(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 32.0,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          account.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              account.telephoneNumber,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            IconButton(
                              iconSize: 16.0,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints.tight(
                                const Size(16.0, 16.0),
                              ),
                              onPressed: () async {
                                final String? telephoneNumber =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute<String>(
                                    builder: (BuildContext context) =>
                                        SingleFormFieldSelectorPage(
                                      title: AppLocalizations.of(context)!
                                          .editTelephoneNumber,
                                      initial: account.telephoneNumber,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!
                                            .telephone_number,
                                      ),
                                      validator: (String? value) =>
                                          Validator.of(context).getErrorMessage(
                                        validationResults: (Validator v) =>
                                            v.telephoneNumberValidator(value),
                                      ),
                                    ),
                                  ),
                                );

                                if (telephoneNumber != null) {
                                  ref
                                      .read(apiProvider)
                                      .accounts
                                      .setTelephoneNumber(
                                        account,
                                        telephoneNumber,
                                      );
                                }
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.user_type,
                  text: account.type.translate(context),
                ),
                if (account.nationality != null)
                  CustomDataRow(
                    label: AppLocalizations.of(context)!.nationality,
                    text: account.nationality!.translate(context),
                  ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.email,
                  text: account.email,
                  onEdit: () async {
                    final String? email = await Navigator.of(context).push(
                      MaterialPageRoute<String>(
                        builder: (BuildContext context) =>
                            SingleFormFieldSelectorPage(
                          title: AppLocalizations.of(context)!.editEmail,
                          initial: account.email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.email,
                          ),
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.emailValidator(value),
                          ),
                        ),
                      ),
                    );

                    if (email != null) {
                      ref.read(apiProvider).accounts.setEmail(
                            account,
                            email,
                          );
                    }
                  },
                ),
                if (account.dateOfBirth != null)
                  CustomDataRow(
                    label: AppLocalizations.of(context)!.dateOfBirth,
                    text: DateFormat.yMd().format(account.dateOfBirth!),
                  ),
                if (account.gender != null)
                  CustomDataRow(
                    label: AppLocalizations.of(context)!.gender,
                    text: account.gender!.translate(context),
                  ),
                if (account.permanentResidentialAddress != null)
                  CustomDataRow(
                    label: AppLocalizations.of(context)!
                        .permanentResidentialAddress,
                    text:
                        account.permanentResidentialAddress!.translate(context),
                    onEdit: () async {
                      final Address? address = await Navigator.of(context).push(
                        MaterialPageRoute<Address>(
                          builder: (BuildContext context) =>
                              AddressSelectorPage(
                            initial: account.permanentResidentialAddress,
                          ),
                        ),
                      );

                      if (address != null) {
                        ref.read(apiProvider).accounts.setAddress(
                              account,
                              address,
                            );
                      }
                    },
                  ),
                if (account.idNumber != null)
                  CustomDataRow(
                    label: AppLocalizations.of(context)!.companyIdNumber,
                    text: account.idNumber!,
                  ),
                if (account.taxIdNumber != null)
                  CustomDataRow(
                    label: AppLocalizations.of(context)!.taxIdNumber,
                    text: account.taxIdNumber!,
                  ),
                if (account.registeredAddress != null)
                  CustomDataRow(
                    label: AppLocalizations.of(context)!.registeredAddress,
                    text: account.registeredAddress!.translate(context),
                    onEdit: () async {
                      final Address? address = await Navigator.of(context).push(
                        MaterialPageRoute<Address>(
                          builder: (BuildContext context) =>
                              AddressSelectorPage(
                            initial: account.registeredAddress,
                          ),
                        ),
                      );

                      if (address != null) {
                        ref.read(apiProvider).accounts.setAddress(
                              account,
                              address,
                            );
                      }
                    },
                  ),
                CustomDataRow(
                  label: AppLocalizations.of(context)!.password,
                  text: '********',
                  onEdit: () async {
                    final PasswordChangeRequest? passwordChangeRequest =
                        await Navigator.of(context).push(
                      MaterialPageRoute<PasswordChangeRequest>(
                        builder: (BuildContext context) => EditPasswordPage(),
                      ),
                    );

                    if (passwordChangeRequest != null) {
                      try {
                        await ref.read(apiProvider).accounts.setPassword(
                              account,
                              passwordChangeRequest,
                            );
                      } on DioException {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!
                                    .failedToUpdatePassword,
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              ref.read(apiProvider).setAuthorization(null);
              Navigator.of(context).pushReplacementNamed(
                SignInPage.route,
              );
            },
            child: Text(AppLocalizations.of(context)!.logout.toUpperCase()),
          ),
        )
      ],
    );
  }
}
