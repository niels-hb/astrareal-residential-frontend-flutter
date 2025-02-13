import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum AccountType { individual, company }

extension Translate on AccountType {
  String translate(BuildContext context) {
    switch (this) {
      case AccountType.company:
        return AppLocalizations.of(context)!.user_type_company;
      case AccountType.individual:
        return AppLocalizations.of(context)!.user_type_individual;
    }
  }
}
