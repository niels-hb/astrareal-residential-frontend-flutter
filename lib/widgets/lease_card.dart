import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../models/access_card.dart';
import '../models/account.dart';
import '../models/account_type.dart';
import '../models/lease.dart';
import '../models/nationality.dart';
import '../models/parking_registration.dart';
import 'custom_data_row.dart';

class LeaseCard extends StatelessWidget {
  const LeaseCard({
    required this.lease,
    super.key,
  });

  final Lease lease;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              lease.unit.building.project.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              lease.unit.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomDataRow(
              label: AppLocalizations.of(context)!.lease_duration,
              text:
                  '${DateFormat.yMd().format(lease.leaseStart)} - ${DateFormat.yMd().format(lease.leaseEnd)}',
            ),
            CustomDataRow(
              label: AppLocalizations.of(context)!.rentalFee,
              text: NumberFormat.simpleCurrency(locale: 'vi_VN')
                  .format(lease.rentalFee),
            ),
            const SizedBox(
              height: 8.0,
            ),
            _buildSubheader(
              context,
              AppLocalizations.of(context)!.lessee_information,
            ),
            ..._buildUserInformation(context, lease.lessee),
            const SizedBox(
              height: 8.0,
            ),
            _buildSubheader(
              context,
              AppLocalizations.of(context)!.lessor_information,
            ),
            ..._buildUserInformation(context, lease.lessor),
            const SizedBox(
              height: 8.0,
            ),
            _buildSubheader(
              context,
              AppLocalizations.of(context)!.building_management_information,
            ),
            ..._buildBuildingManagementInformation(context),
            if (lease.leaseTerms.isNotEmpty) ...<Widget>[
              const SizedBox(
                height: 8.0,
              ),
              _buildSubheader(
                context,
                AppLocalizations.of(context)!.lease_terms,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(lease.leaseTerms),
            ],
            if (lease.unit.accessCards.isNotEmpty) ...<Widget>[
              const SizedBox(
                height: 8.0,
              ),
              _buildSubheader(
                context,
                AppLocalizations.of(context)!.access_cards,
              ),
              const SizedBox(
                height: 4.0,
              ),
              _buildAccessCards(context, lease.unit.accessCards),
            ],
            if (lease.unit.accessCards
                .expand(
                  (AccessCard accessCard) => accessCard.parkingRegistrations,
                )
                .isNotEmpty) ...<Widget>[
              const SizedBox(
                height: 8.0,
              ),
              _buildSubheader(
                context,
                AppLocalizations.of(context)!.parking,
              ),
              const SizedBox(
                height: 4.0,
              ),
              _buildParking(
                context,
                lease.unit.accessCards
                    .expand(
                      (AccessCard accessCard) =>
                          accessCard.parkingRegistrations,
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Table _buildAccessCards(BuildContext context, List<AccessCard> accessCards) {
    return Table(
      border: TableBorder.all(),
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            _buildTableCell(
              context,
              AppLocalizations.of(context)!.card_number,
              header: true,
            ),
            _buildTableCell(
              context,
              AppLocalizations.of(context)!.owner,
              header: true,
            ),
          ],
        ),
        for (AccessCard accessCard in accessCards)
          TableRow(
            children: <Widget>[
              _buildTableCell(
                context,
                accessCard.number,
              ),
              _buildTableCell(
                context,
                accessCard.owner.name,
              ),
            ],
          ),
      ],
    );
  }

  Table _buildParking(
      BuildContext context, List<ParkingRegistration> parkingRegistrations) {
    return Table(
      border: TableBorder.all(),
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            _buildTableCell(
              context,
              AppLocalizations.of(context)!.card_number,
              header: true,
            ),
            _buildTableCell(
              context,
              AppLocalizations.of(context)!.plate_number,
              header: true,
            ),
            _buildTableCell(
              context,
              AppLocalizations.of(context)!.brand,
              header: true,
            ),
            _buildTableCell(
              context,
              AppLocalizations.of(context)!.model,
              header: true,
            ),
            _buildTableCell(
              context,
              AppLocalizations.of(context)!.color,
              header: true,
            ),
          ],
        ),
        for (ParkingRegistration parkingRegistration in parkingRegistrations)
          TableRow(
            children: <Widget>[
              _buildTableCell(
                context,
                parkingRegistration.accessCard.number,
              ),
              _buildTableCell(
                context,
                parkingRegistration.plateNumber,
              ),
              _buildTableCell(
                context,
                parkingRegistration.brand,
              ),
              _buildTableCell(
                context,
                parkingRegistration.model,
              ),
              _buildTableCell(
                context,
                parkingRegistration.color,
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildSubheader(
    BuildContext context,
    String title,
  ) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  Widget _buildTableCell(
    BuildContext context,
    String text, {
    bool header = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: header ? Theme.of(context).textTheme.labelLarge : null,
      ),
    );
  }

  List<Widget> _buildUserInformation(BuildContext context, Account user) {
    return <Widget>[
      CustomDataRow(
        label: AppLocalizations.of(context)!.user_type,
        text: user.type.translate(context),
      ),
      CustomDataRow(
        label: AppLocalizations.of(context)!.name,
        text: user.name,
      ),
      CustomDataRow(
        label: AppLocalizations.of(context)!.telephone_number,
        text: user.telephoneNumber,
      ),
      if (user.nationality != null)
        CustomDataRow(
          label: AppLocalizations.of(context)!.nationality,
          text: user.nationality!.translate(context),
        ),
    ];
  }

  List<Widget> _buildBuildingManagementInformation(BuildContext context) {
    return <Widget>[
      CustomDataRow(
        label: AppLocalizations.of(context)!.reception,
        text: lease.unit.building.telephoneNumberReception ?? 'N/A',
      ),
      CustomDataRow(
        label: AppLocalizations.of(context)!.security,
        text: lease.unit.building.telephoneNumberSecurity ?? 'N/A',
      ),
      CustomDataRow(
        label: AppLocalizations.of(context)!.office,
        text: lease.unit.building.telephoneNumberOffice ?? 'N/A',
      ),
    ];
  }
}
