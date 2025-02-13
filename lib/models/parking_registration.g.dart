// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingRegistration _$ParkingRegistrationFromJson(Map<String, dynamic> json) =>
    ParkingRegistration(
      accessCard:
          AccessCard.fromJson(json['accessCard'] as Map<String, dynamic>),
      plateNumber: json['plateNumber'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$ParkingRegistrationToJson(
        ParkingRegistration instance) =>
    <String, dynamic>{
      'accessCard': instance.accessCard,
      'plateNumber': instance.plateNumber,
      'brand': instance.brand,
      'model': instance.model,
      'color': instance.color,
    };
