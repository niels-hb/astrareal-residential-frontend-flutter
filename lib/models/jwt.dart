import 'package:json_annotation/json_annotation.dart';

part 'jwt.g.dart';

@JsonSerializable()
class Jwt {
  Jwt({
    required this.iss,
    required this.sub,
    required this.aud,
    required this.exp,
    required this.nbf,
    required this.iat,
    required this.jti,
  });

  factory Jwt.fromJson(Map<String, dynamic> json) => _$JwtFromJson(json);

  final String iss;
  final String sub;
  final String aud;
  final int exp;
  final int nbf;
  final int iat;
  final String jti;

  Map<String, dynamic> toJson() => _$JwtToJson(this);
}
