import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'project.dart';

part 'building.g.dart';

@JsonSerializable()
@immutable
class Building {
  const Building({
    this.id,
    required this.address,
    required this.name,
    required this.project,
    this.telephoneNumberReception,
    this.telephoneNumberSecurity,
    this.telephoneNumberOffice,
  });

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);

  final String? id;
  final Address address;
  final String name;
  final Project project;
  final String? telephoneNumberReception;
  final String? telephoneNumberSecurity;
  final String? telephoneNumberOffice;

  Map<String, dynamic> toJson() => _$BuildingToJson(this);

  @override
  bool operator ==(Object other) => other is Building && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
