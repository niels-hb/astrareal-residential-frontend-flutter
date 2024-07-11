import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/request_type.dart';
import '../../widgets/custom_app_bar.dart';
import 'furniture_form.dart';

StateProvider<RequestType> _selectedRequestTypeProvider =
    StateProvider<RequestType>(
  (StateProviderRef<RequestType> ref) => RequestType.values.first,
);

class AddRequestPage extends ConsumerWidget {
  const AddRequestPage({super.key});

  static const String route = '/add_request';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RequestType selectedRequestType =
        ref.watch(_selectedRequestTypeProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.addRequest,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.selectTypeOfRequest,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ...RequestType.values.map(
                    (RequestType e) => RadioMenuButton<RequestType>(
                      value: e,
                      groupValue: selectedRequestType,
                      onChanged: (RequestType? selected) {
                        ref.read(_selectedRequestTypeProvider.notifier).state =
                            selected!;
                      },
                      child: Text(e.translate(context)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    selectedRequestType.translate(context),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  _formBasedOnSelectedRequestType(selectedRequestType),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _formBasedOnSelectedRequestType(RequestType requestType) {
    switch (requestType) {
      case RequestType.movingFurnitureIn:
      case RequestType.movingFurnitureOut:
        return FurnitureForm(type: requestType);
    }
  }
}
