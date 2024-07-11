// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_lease_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLeaseRequest _$CreateLeaseRequestFromJson(Map<String, dynamic> json) =>
    CreateLeaseRequest(
      id: json['id'] as String?,
      lessor: Account.fromJson(json['lessor'] as Map<String, dynamic>),
      lessee: AccountEmail.fromJson(json['lessee'] as Map<String, dynamic>),
      leaseStart: DateTime.parse(json['leaseStart'] as String),
      leaseEnd: DateTime.parse(json['leaseEnd'] as String),
      leaseTerms: json['leaseTerms'] as String,
      rentalFee: json['rentalFee'] as int,
      unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateLeaseRequestToJson(CreateLeaseRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessor': instance.lessor,
      'lessee': instance.lessee,
      'leaseStart': instance.leaseStart.toIso8601String(),
      'leaseEnd': instance.leaseEnd.toIso8601String(),
      'rentalFee': instance.rentalFee,
      'leaseTerms': instance.leaseTerms,
      'unit': instance.unit,
    };
