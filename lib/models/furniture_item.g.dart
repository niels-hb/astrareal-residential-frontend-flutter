// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'furniture_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FurnitureItem _$FurnitureItemFromJson(Map<String, dynamic> json) =>
    FurnitureItem(
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      depth: json['depth'] as int,
    );

Map<String, dynamic> _$FurnitureItemToJson(FurnitureItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
    };
