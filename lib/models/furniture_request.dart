import 'package:freezed_annotation/freezed_annotation.dart';

import 'account.dart';
import 'furniture_item.dart';
import 'furniture_requirements.dart';
import 'request.dart';
import 'request_type.dart';
import 'unit.dart';

part 'furniture_request.g.dart';

@JsonSerializable()
class FurnitureRequest extends Request {
  FurnitureRequest({
    super.id,
    required super.type,
    required super.unit,
    super.requestedBy,
    super.approvedBy,
    super.executedBy,
    required this.items,
    required this.movingDate,
    required this.movingTimeFrom,
    required this.movingTimeTo,
    required this.requirements,
    required super.denied,
    super.denialReason,
    this.otherRequirements,
    this.notes,
  });

  factory FurnitureRequest.fromJson(Map<String, dynamic> json) =>
      _$FurnitureRequestFromJson(json);

  final List<FurnitureItem> items;
  final DateTime movingDate;
  final DateTime movingTimeFrom;
  final DateTime movingTimeTo;
  final List<FurnitureRequirements> requirements;
  final String? otherRequirements;
  final String? notes;

  @override
  Map<String, dynamic> toJson() => _$FurnitureRequestToJson(this);
}
