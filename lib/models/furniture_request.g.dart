// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'furniture_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FurnitureRequest _$FurnitureRequestFromJson(Map<String, dynamic> json) =>
    FurnitureRequest(
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
      items: (json['items'] as List<dynamic>)
          .map((e) => FurnitureItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      movingDate: DateTime.parse(json['movingDate'] as String),
      movingTimeFrom: DateTime.parse(json['movingTimeFrom'] as String),
      movingTimeTo: DateTime.parse(json['movingTimeTo'] as String),
      requirements: (json['requirements'] as List<dynamic>)
          .map((e) => $enumDecode(_$FurnitureRequirementsEnumMap, e))
          .toList(),
      denied: json['denied'] as bool,
      denialReason: json['denialReason'] as String?,
      otherRequirements: json['otherRequirements'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$FurnitureRequestToJson(FurnitureRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$RequestTypeEnumMap[instance.type]!,
      'unit': instance.unit,
      'requestedBy': instance.requestedBy,
      'approvedBy': instance.approvedBy,
      'executedBy': instance.executedBy,
      'denied': instance.denied,
      'denialReason': instance.denialReason,
      'items': instance.items,
      'movingDate': instance.movingDate.toIso8601String(),
      'movingTimeFrom': instance.movingTimeFrom.toIso8601String(),
      'movingTimeTo': instance.movingTimeTo.toIso8601String(),
      'requirements': instance.requirements
          .map((e) => _$FurnitureRequirementsEnumMap[e]!)
          .toList(),
      'otherRequirements': instance.otherRequirements,
      'notes': instance.notes,
    };

const _$RequestTypeEnumMap = {
  RequestType.movingFurnitureIn: 'MOVING_FURNITURE_IN',
  RequestType.movingFurnitureOut: 'MOVING_FURNITURE_OUT',
};

const _$FurnitureRequirementsEnumMap = {
  FurnitureRequirements.trolley: 'TROLLEY',
  FurnitureRequirements.vanParking: 'VAN_PARKING',
  FurnitureRequirements.cargoLift: 'CARGO_LIFT',
  FurnitureRequirements.other: 'OTHER',
};
