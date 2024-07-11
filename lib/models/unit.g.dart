// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      id: json['id'] as String?,
      name: json['name'] as String,
      accessCards: (json['accessCards'] as List<dynamic>)
          .map((e) => AccessCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      building: Building.fromJson(json['building'] as Map<String, dynamic>),
      owner: Account.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'accessCards': instance.accessCards,
      'building': instance.building,
      'owner': instance.owner,
    };
