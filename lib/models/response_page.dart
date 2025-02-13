import 'package:json_annotation/json_annotation.dart';

part 'response_page.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponsePage<T> {
  ResponsePage({
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.first,
    required this.size,
    required this.number,
    required this.numberOfElements,
    required this.empty,
    required this.content,
  });

  factory ResponsePage.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ResponsePageFromJson(
        json,
        fromJsonT,
      );

  final List<T> content;
  final bool last;
  final int totalPages;
  final int totalElements;
  final bool first;
  final int size;
  final int number;
  final int numberOfElements;
  final bool empty;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      _$ResponsePageToJson(
        this,
        toJsonT,
      );
}
