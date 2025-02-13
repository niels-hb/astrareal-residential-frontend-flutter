import 'package:json_annotation/json_annotation.dart';
import 'access_card.dart';

part 'parking_registration.g.dart';

@JsonSerializable()
class ParkingRegistration {
  ParkingRegistration({
    required this.accessCard,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.color,
  });

  factory ParkingRegistration.fromJson(Map<String, dynamic> json) =>
      _$ParkingRegistrationFromJson(json);

  final AccessCard accessCard;
  final String plateNumber;
  final String brand;
  final String model;
  final String color;

  Map<String, dynamic> toJson() => _$ParkingRegistrationToJson(this);
}
