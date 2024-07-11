import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum FurnitureRequirements {
  trolley,
  vanParking,
  cargoLift,
  other,
}

extension Translate on FurnitureRequirements {
  String translate(BuildContext context) {
    switch (this) {
      case FurnitureRequirements.trolley:
        return AppLocalizations.of(context)!.requiresTrolley;
      case FurnitureRequirements.vanParking:
        return AppLocalizations.of(context)!.requiresVanParking;
      case FurnitureRequirements.cargoLift:
        return AppLocalizations.of(context)!.usingCargoLift;
      case FurnitureRequirements.other:
        return AppLocalizations.of(context)!.other;
    }
  }
}
