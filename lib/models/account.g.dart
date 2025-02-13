// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Account _$$_AccountFromJson(Map<String, dynamic> json) => _$_Account(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      telephoneNumber: json['telephoneNumber'] as String,
      password: json['password'] as String?,
      type: $enumDecode(_$AccountTypeEnumMap, json['type']),
      nationality:
          $enumDecodeNullable(_$NationalityEnumMap, json['nationality']),
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      permanentResidentialAddress: json['permanentResidentialAddress'] == null
          ? null
          : Address.fromJson(
              json['permanentResidentialAddress'] as Map<String, dynamic>),
      identification: json['identification'] == null
          ? null
          : Identification.fromJson(
              json['identification'] as Map<String, dynamic>),
      idNumber: json['idNumber'] as String?,
      taxIdNumber: json['taxIdNumber'] as String?,
      registeredAddress: json['registeredAddress'] == null
          ? null
          : Address.fromJson(json['registeredAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'telephoneNumber': instance.telephoneNumber,
      'password': instance.password,
      'type': _$AccountTypeEnumMap[instance.type]!,
      'nationality': _$NationalityEnumMap[instance.nationality],
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender],
      'permanentResidentialAddress': instance.permanentResidentialAddress,
      'identification': instance.identification,
      'idNumber': instance.idNumber,
      'taxIdNumber': instance.taxIdNumber,
      'registeredAddress': instance.registeredAddress,
    };

const _$AccountTypeEnumMap = {
  AccountType.individual: 'INDIVIDUAL',
  AccountType.company: 'COMPANY',
};

const _$NationalityEnumMap = {
  Nationality.vietnamese: 'VIETNAMESE',
  Nationality.german: 'GERMAN',
};

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
};
