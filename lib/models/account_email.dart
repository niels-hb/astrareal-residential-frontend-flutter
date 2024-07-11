import 'package:json_annotation/json_annotation.dart';

part 'account_email.g.dart';

@JsonSerializable()
class AccountEmail {
  AccountEmail({
    required this.email,
  });

  factory AccountEmail.fromJson(Map<String, dynamic> json) =>
      _$AccountEmailFromJson(json);

  final String email;

  Map<String, dynamic> toJson() => _$AccountEmailToJson(this);
}
