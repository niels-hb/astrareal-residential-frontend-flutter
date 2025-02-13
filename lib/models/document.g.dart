// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      name: json['name'] as String,
      type: $enumDecode(_$FileTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'name': instance.name,
      'type': _$FileTypeEnumMap[instance.type]!,
    };

const _$FileTypeEnumMap = {
  FileType.imagePng: 'IMAGE_PNG',
  FileType.imageJpg: 'IMAGE_JPG',
  FileType.applicationPdf: 'APPLICATION_PDF',
};
