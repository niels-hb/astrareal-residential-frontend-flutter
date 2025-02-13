import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Nationality { vietnamese, german }

extension Translate on Nationality {
  String translate(BuildContext context) {
    switch (this) {
      case Nationality.german:
        return AppLocalizations.of(context)!.german;
      case Nationality.vietnamese:
        return AppLocalizations.of(context)!.vietnamese;
    }
  }
}

Nationality? nationalityFromTranslation(
  BuildContext context,
  String? translation,
) {
  return Nationality.values.cast<Nationality?>().firstWhere(
        (Nationality? element) =>
            element!.translate(context).toLowerCase() ==
            translation?.toLowerCase(),
        orElse: () => null,
      );
}
