// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jwt _$JwtFromJson(Map<String, dynamic> json) => Jwt(
      iss: json['iss'] as String,
      sub: json['sub'] as String,
      aud: json['aud'] as String,
      exp: json['exp'] as int,
      nbf: json['nbf'] as int,
      iat: json['iat'] as int,
      jti: json['jti'] as String,
    );

Map<String, dynamic> _$JwtToJson(Jwt instance) => <String, dynamic>{
      'iss': instance.iss,
      'sub': instance.sub,
      'aud': instance.aud,
      'exp': instance.exp,
      'nbf': instance.nbf,
      'iat': instance.iat,
      'jti': instance.jti,
    };
