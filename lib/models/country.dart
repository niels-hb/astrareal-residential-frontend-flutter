import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Country { germany, vietnam }

extension Translate on Country {
  String translate(BuildContext context) {
    switch (this) {
      case Country.germany:
        return AppLocalizations.of(context)!.germany;
      case Country.vietnam:
        return AppLocalizations.of(context)!.vietnam;
    }
  }
}

Country? countryFromTranslation(
  BuildContext context,
  String? translation,
) {
  return Country.values.cast<Country?>().firstWhere(
        (Country? element) =>
            element!.translate(context).toLowerCase() ==
            translation?.toLowerCase(),
        orElse: () => null,
      );
}
