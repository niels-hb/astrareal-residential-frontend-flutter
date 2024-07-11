// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessCard _$AccessCardFromJson(Map<String, dynamic> json) => AccessCard(
      id: json['id'] as String,
      number: json['number'] as String,
      unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
      owner: Account.fromJson(json['owner'] as Map<String, dynamic>),
      parkingRegistrations: (json['parkingRegistrations'] as List<dynamic>?)
              ?.map((e) =>
                  ParkingRegistration.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ParkingRegistration>[],
    );

Map<String, dynamic> _$AccessCardToJson(AccessCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'unit': instance.unit,
      'owner': instance.owner,
      'parkingRegistrations': instance.parkingRegistrations,
    };
