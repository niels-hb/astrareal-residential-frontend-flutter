import 'package:json_annotation/json_annotation.dart';

part 'password_change_request.g.dart';

@JsonSerializable()
class PasswordChangeRequest {
  PasswordChangeRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;

  Map<String, dynamic> toJson() => _$PasswordChangeRequestToJson(this);
}
