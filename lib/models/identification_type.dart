import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum IdentificationType { passport, idCard }

extension Translate on IdentificationType {
  String translate(BuildContext context) {
    switch (this) {
      case IdentificationType.passport:
        return AppLocalizations.of(context)!.passport;
      case IdentificationType.idCard:
        return AppLocalizations.of(context)!.idCard;
    }
  }
}
