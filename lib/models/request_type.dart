import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum RequestType { movingFurnitureIn, movingFurnitureOut }

extension Translate on RequestType {
  String translate(BuildContext context) {
    switch (this) {
      case RequestType.movingFurnitureIn:
        return AppLocalizations.of(context)!.moveFurnitureIntoUnit;
      case RequestType.movingFurnitureOut:
        return AppLocalizations.of(context)!.moveFurnitureOutOfUnit;
    }
  }
}
