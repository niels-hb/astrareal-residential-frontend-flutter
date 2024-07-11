import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'jwt.dart';

part 'oauth2_response.g.dart';

@JsonSerializable()
class OAuth2Response {
  OAuth2Response({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.tokenType,
  }) : decodedAccessToken = JwtDecoder.tryDecode(accessToken) != null
            ? Jwt.fromJson(JwtDecoder.tryDecode(accessToken)!)
            : null;

  factory OAuth2Response.fromJson(Map<String, dynamic> json) =>
      _$OAuth2ResponseFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;

  final Jwt? decodedAccessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'token_type')
  final String tokenType;

  @JsonKey(name: 'expires_in')
  final int expiresIn;

  Map<String, dynamic> toJson() => _$OAuth2ResponseToJson(this);
}
