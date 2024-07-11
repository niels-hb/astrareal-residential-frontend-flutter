// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      id: json['id'] as String?,
      type: $enumDecode(_$RequestTypeEnumMap, json['type']),
      unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
      requestedBy: json['requestedBy'] == null
          ? null
          : Account.fromJson(json['requestedBy'] as Map<String, dynamic>),
      approvedBy: json['approvedBy'] == null
          ? null
          : Account.fromJson(json['approvedBy'] as Map<String, dynamic>),
      executedBy: json['executedBy'] == null
          ? null
          : Account.fromJson(json['executedBy'] as Map<String, dynamic>),
      denied: json['denied'] as bool,
      denialReason: json['denialReason'] as String?,
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$RequestTypeEnumMap[instance.type]!,
      'unit': instance.unit,
      'requestedBy': instance.requestedBy,
      'approvedBy': instance.approvedBy,
      'executedBy': instance.executedBy,
      'denied': instance.denied,
      'denialReason': instance.denialReason,
    };

const _$RequestTypeEnumMap = {
  RequestType.movingFurnitureIn: 'MOVING_FURNITURE_IN',
  RequestType.movingFurnitureOut: 'MOVING_FURNITURE_OUT',
};
