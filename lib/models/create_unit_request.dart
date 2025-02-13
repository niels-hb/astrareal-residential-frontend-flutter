import 'package:json_annotation/json_annotation.dart';

import 'account_email.dart';
import 'building.dart';

part 'create_unit_request.g.dart';

@JsonSerializable()
class CreateUnitRequest {
  CreateUnitRequest({
    required this.name,
    required this.building,
    required this.owner,
  });

  factory CreateUnitRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUnitRequestFromJson(json);

  final String name;
  final Building building;
  final AccountEmail owner;

  Map<String, dynamic> toJson() => _$CreateUnitRequestToJson(this);
}
