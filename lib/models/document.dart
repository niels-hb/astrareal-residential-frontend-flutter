import 'package:json_annotation/json_annotation.dart';

import 'file_type.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  Document({
    required this.name,
    required this.type,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  final String name;
  final FileType type;

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
