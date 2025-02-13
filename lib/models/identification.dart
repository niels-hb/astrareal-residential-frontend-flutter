import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'identification_type.dart';

part 'identification.g.dart';

@JsonSerializable()
class Identification {
  Identification({
    required this.type,
    required this.idNumber,
    required this.fullName,
  });

  factory Identification.fromJson(Map<String, dynamic> json) =>
      _$IdentificationFromJson(json);

  final IdentificationType type;
  final String idNumber;
  final String fullName;

  Map<String, dynamic> toJson() => _$IdentificationToJson(this);

  String translate(BuildContext context) {
    return '''
$idNumber - $fullName
(${type.translate(context)})
''';
  }
}
