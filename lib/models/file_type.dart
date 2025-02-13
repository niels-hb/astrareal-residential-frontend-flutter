import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum FileType { imagePng, imageJpg, applicationPdf }

extension Translate on FileType {
  String translate(BuildContext context) {
    switch (this) {
      case FileType.imagePng:
      case FileType.imageJpg:
        return AppLocalizations.of(context)!.image;
      case FileType.applicationPdf:
        return AppLocalizations.of(context)!.pdf;
    }
  }
}
