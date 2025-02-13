// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lease.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lease _$LeaseFromJson(Map<String, dynamic> json) => Lease(
      id: json['id'] as String?,
      lessor: Account.fromJson(json['lessor'] as Map<String, dynamic>),
      lessee: Account.fromJson(json['lessee'] as Map<String, dynamic>),
      leaseStart: DateTime.parse(json['leaseStart'] as String),
      leaseEnd: DateTime.parse(json['leaseEnd'] as String),
      rentalFee: json['rentalFee'] as int,
      leaseTerms: json['leaseTerms'] as String,
      unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeaseToJson(Lease instance) => <String, dynamic>{
      'id': instance.id,
      'lessor': instance.lessor,
      'lessee': instance.lessee,
      'leaseStart': instance.leaseStart.toIso8601String(),
      'leaseEnd': instance.leaseEnd.toIso8601String(),
      'rentalFee': instance.rentalFee,
      'leaseTerms': instance.leaseTerms,
      'unit': instance.unit,
    };
