import 'package:json_annotation/json_annotation.dart';

part 'furniture_item.g.dart';

@JsonSerializable()
class FurnitureItem {
  FurnitureItem({
    required this.name,
    required this.quantity,
    required this.width,
    required this.height,
    required this.depth,
  });

  factory FurnitureItem.fromJson(Map<String, dynamic> json) =>
      _$FurnitureItemFromJson(json);

  final String name;
  final int quantity;
  final int width;
  final int height;
  final int depth;

  Map<String, dynamic> toJson() => _$FurnitureItemToJson(this);
}
