// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) => Building(
      id: json['id'] as String?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      name: json['name'] as String,
      project: Project.fromJson(json['project'] as Map<String, dynamic>),
      telephoneNumberReception: json['telephoneNumberReception'] as String?,
      telephoneNumberSecurity: json['telephoneNumberSecurity'] as String?,
      telephoneNumberOffice: json['telephoneNumberOffice'] as String?,
    );

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'name': instance.name,
      'project': instance.project,
      'telephoneNumberReception': instance.telephoneNumberReception,
      'telephoneNumberSecurity': instance.telephoneNumberSecurity,
      'telephoneNumberOffice': instance.telephoneNumberOffice,
    };
