// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_change_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordChangeRequest _$PasswordChangeRequestFromJson(
        Map<String, dynamic> json) =>
    PasswordChangeRequest(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$PasswordChangeRequestToJson(
        PasswordChangeRequest instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
    };
