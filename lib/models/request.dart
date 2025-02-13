import 'package:json_annotation/json_annotation.dart';

import 'account.dart';
import 'furniture_request.dart';
import 'request_type.dart';
import 'unit.dart';

part 'request.g.dart';

@JsonSerializable()
class Request {
  Request({
    this.id,
    required this.type,
    required this.unit,
    this.requestedBy,
    this.approvedBy,
    this.executedBy,
    required this.denied,
    this.denialReason,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    switch ($enumDecode(_$RequestTypeEnumMap, json['type'])) {
      case RequestType.movingFurnitureIn:
      case RequestType.movingFurnitureOut:
        return FurnitureRequest.fromJson(json);
    }
  }

  final String? id;
  final RequestType type;
  final Unit unit;
  final Account? requestedBy;
  final Account? approvedBy;
  final Account? executedBy;
  final bool denied;
  final String? denialReason;

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
