// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identification _$IdentificationFromJson(Map<String, dynamic> json) =>
    Identification(
      type: $enumDecode(_$IdentificationTypeEnumMap, json['type']),
      idNumber: json['idNumber'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$IdentificationToJson(Identification instance) =>
    <String, dynamic>{
      'type': _$IdentificationTypeEnumMap[instance.type]!,
      'idNumber': instance.idNumber,
      'fullName': instance.fullName,
    };

const _$IdentificationTypeEnumMap = {
  IdentificationType.passport: 'PASSPORT',
  IdentificationType.idCard: 'ID_CARD',
};
