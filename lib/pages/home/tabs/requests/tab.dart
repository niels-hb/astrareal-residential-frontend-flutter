import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/request.dart';
import '../../../../models/response_page.dart';
import '../../../../providers/requests.dart';
import '../../../../widgets/request_card.dart';

class RequestsTab extends ConsumerWidget {
  const RequestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ResponsePage<Request>> requests =
        ref.watch(requestsOfUserProvider);

    return requests.when(
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      data: (ResponsePage<Request> data) {
        if (data.totalElements == 0) {
          return Center(
            child: Text(AppLocalizations.of(context)!.emptyRequests),
          );
        } else {
          return ListView.separated(
            itemCount: data.totalElements + 1,
            separatorBuilder: (BuildContext context, int _) => const SizedBox(
              height: 16.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == data.totalElements) {
                return const SizedBox(
                  height: 64.0,
                );
              }

              return RequestCard(
                request: data.content[index],
              );
            },
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
}
