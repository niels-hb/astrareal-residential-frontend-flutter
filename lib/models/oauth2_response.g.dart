// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth2_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuth2Response _$OAuth2ResponseFromJson(Map<String, dynamic> json) =>
    OAuth2Response(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: json['expires_in'] as int,
      tokenType: json['token_type'] as String,
    );

Map<String, dynamic> _$OAuth2ResponseToJson(OAuth2Response instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
