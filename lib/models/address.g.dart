// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      country: $enumDecode(_$CountryEnumMap, json['country']),
      city: json['city'] as String,
      postalCode: json['postalCode'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'country': _$CountryEnumMap[instance.country]!,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
    };

const _$CountryEnumMap = {
  Country.germany: 'GERMANY',
  Country.vietnam: 'VIETNAM',
};
