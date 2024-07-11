import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
@immutable
class Project {
  const Project({
    this.id,
    required this.name,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  final String? id;
  final String name;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  bool operator ==(Object other) => other is Project && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
