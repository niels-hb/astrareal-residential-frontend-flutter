import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Gender { male, female }

extension Translate on Gender {
  String translate(BuildContext context) {
    switch (this) {
      case Gender.female:
        return AppLocalizations.of(context)!.female;
      case Gender.male:
        return AppLocalizations.of(context)!.male;
    }
  }
}
