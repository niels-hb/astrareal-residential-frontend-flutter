import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'access_card.dart';
import 'account.dart';
import 'building.dart';

part 'unit.g.dart';

@JsonSerializable()
@immutable
class Unit {
  const Unit({
    this.id,
    required this.name,
    required this.accessCards,
    required this.building,
    required this.owner,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  final String? id;
  final String name;
  final List<AccessCard> accessCards;
  final Building building;
  final Account owner;

  Map<String, dynamic> toJson() => _$UnitToJson(this);

  @override
  bool operator ==(Object other) => other is Unit && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
