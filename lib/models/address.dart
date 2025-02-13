import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'country.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  Address({
    required this.country,
    required this.city,
    required this.postalCode,
    required this.addressLine1,
    required this.addressLine2,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final Country country;
  final String city;
  final String postalCode;
  final String addressLine1;
  final String? addressLine2;

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String translate(BuildContext context) {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln(addressLine1);
    if (addressLine2?.isNotEmpty ?? false) {
      buffer.writeln(addressLine2);
    }
    buffer.writeln('$postalCode $city');
    buffer.write(country.translate(context));

    return buffer.toString();
  }
}
