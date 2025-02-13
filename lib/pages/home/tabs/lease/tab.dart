import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/lease.dart';
import '../../../../models/response_page.dart';
import '../../../../providers/leases.dart';
import '../../../../widgets/lease_card.dart';

class LeaseTab extends ConsumerWidget {
  const LeaseTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ResponsePage<Lease>> units = ref.watch(leasesProvider);

    return units.when(
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      data: (ResponsePage<Lease> data) {
        if (data.totalElements == 0) {
          return Center(
            child: Text(AppLocalizations.of(context)!.emptyLeases),
          );
        } else {
          return ListView.separated(
            itemCount: data.totalElements,
            separatorBuilder: (BuildContext context, int _) => const SizedBox(
              height: 16.0,
            ),
            itemBuilder: (BuildContext context, int index) => LeaseCard(
              lease: data.content[index],
            ),
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
