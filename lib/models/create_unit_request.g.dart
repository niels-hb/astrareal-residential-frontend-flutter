// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_unit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUnitRequest _$CreateUnitRequestFromJson(Map<String, dynamic> json) =>
    CreateUnitRequest(
      name: json['name'] as String,
      building: Building.fromJson(json['building'] as Map<String, dynamic>),
      owner: AccountEmail.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateUnitRequestToJson(CreateUnitRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'building': instance.building,
      'owner': instance.owner,
    };
