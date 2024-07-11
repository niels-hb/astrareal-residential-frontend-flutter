import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../api/api.dart';
import '../../../../build_information/build_information.dart';
import '../../../../models/account.dart';
import '../../../../models/furniture_item.dart';
import '../../../../models/furniture_request.dart';
import '../../../../models/furniture_requirements.dart';
import '../../../../models/request_type.dart';
import '../../../../providers/api.dart';
import '../../../../providers/authentication.dart';
import '../../../../util/validator.dart';
import '../../../../widgets/loading_button.dart';

class FurnitureRequestCard extends ConsumerWidget {
  const FurnitureRequestCard({
    super.key,
    required this.request,
  });

  final FurnitureRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${request.type.translate(context)} ${request.unit.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            '${DateFormat.yMd().format(request.movingDate)} ${DateFormat.Hm().format(request.movingTimeFrom)} - ${DateFormat.Hm().format(request.movingTimeTo)}',
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildApprovalStep(
                account: request.requestedBy,
                approved: true,
                labelText: AppLocalizations.of(context)!.you,
              ),
              _buildApprovalStep(
                account: request.approvedBy,
                approved: request.approvedBy != null && !request.denied,
                labelText: AppLocalizations.of(context)!.landlord,
              ),
              _buildApprovalStep(
                account: request.executedBy,
                approved: request.executedBy != null,
                labelText: AppLocalizations.of(context)!.building,
              ),
            ],
          ),
          if (request.denialReason?.isNotEmpty ?? false) ...<Widget>[
            const SizedBox(
              height: 8.0,
            ),
            Text(
              AppLocalizations.of(context)!.denialReason,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(request.denialReason!),
          ],
          const SizedBox(
            height: 8.0,
          ),
          Text(
            AppLocalizations.of(context)!.items,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            request.items
                .map(
                  (FurnitureItem e) =>
                      '* ${AppLocalizations.of(context)!.furnitureItem(
                    e.quantity,
                    e.name,
                    e.width,
                    e.height,
                    e.depth,
                  )}',
                )
                .join('\n'),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            AppLocalizations.of(context)!.specialRequirements,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            request.requirements
                .map(
                  (FurnitureRequirements e) =>
                      '* ${e == FurnitureRequirements.other ? '${e.translate(context)} (${request.otherRequirements})' : e.translate(context)}',
                )
                .join('\n'),
          ),
          if (request.notes?.isNotEmpty ?? false) ...<Widget>[
            const SizedBox(
              height: 8.0,
            ),
            Text(
              AppLocalizations.of(context)!.notes,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(request.notes!),
          ],
          _buildActions(context, ref),
        ],
      ),
    );
  }

  Widget _buildApprovalStep({
    required Account? account,
    required bool approved,
    required String labelText,
  }) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            const CircleAvatar(),
            if (account != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  approved ? Icons.check : Icons.close,
                  color: approved ? Colors.green : Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(account?.name ?? labelText),
      ],
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    final Api api = ref.read(apiProvider);
    final Account? authenticatedUser = ref
        .watch(
          authenticatedUserProvider,
        )
        .valueOrNull;

    final List<Widget> availableActions = <Widget>[];

    if (request.unit.owner.id == authenticatedUser?.id &&
        request.executedBy == null) {
      availableActions.addAll(<Widget>[
        if (!request.denied)
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () async {
              final String? denialReason = await _showDenyDialog(context);

              if (denialReason?.isNotEmpty ?? false) {
                await api.requests.deny(request, denialReason!);
              }
            },
          ),
        if (request.approvedBy == null || request.denied)
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            onPressed: () async {
              await api.requests.approve(request);
            },
          ),
      ]);
    }

    if (request.requestedBy?.id == authenticatedUser?.id &&
        request.approvedBy == null) {
      availableActions.addAll(<Widget>[
        IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(AppLocalizations.of(context)!.deleteRequest),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancel.toUpperCase(),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await api.requests.delete(request);

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.ok.toUpperCase(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]);
    }

    if (buildInformation.buildType == BuildType.management &&
        request.approvedBy != null &&
        !request.denied &&
        request.executedBy == null) {
      availableActions.addAll(<Widget>[
        LoadingButton<void>(
          child: Text(
            AppLocalizations.of(context)!.execute.toUpperCase(),
          ),
          onPressed: () async {
            await api.requests.execute(request);
          },
        ),
      ]);
    }

    if (availableActions.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: availableActions,
      ),
    );
  }

  Future<String?> _showDenyDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        final TextEditingController controller = TextEditingController();

        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.denyRequest),
            content: TextFormField(
              controller: controller,
              validator: (String? value) =>
                  Validator.of(context).getErrorMessage(
                validationResults: (Validator v) =>
                    v.requiredFieldValidator(value),
              ),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.reason,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.cancel.toUpperCase()),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop(controller.text);
                  }
                },
                child: Text(AppLocalizations.of(context)!.ok.toUpperCase()),
              ),
            ],
          ),
        );
      },
    );
  }
}
