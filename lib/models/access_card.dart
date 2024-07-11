import 'package:json_annotation/json_annotation.dart';

import 'account.dart';
import 'parking_registration.dart';
import 'unit.dart';

part 'access_card.g.dart';

@JsonSerializable()
class AccessCard {
  AccessCard({
    required this.id,
    required this.number,
    required this.unit,
    required this.owner,
    this.parkingRegistrations = const <ParkingRegistration>[],
  });

  factory AccessCard.fromJson(Map<String, dynamic> json) =>
      _$AccessCardFromJson(json);

  final String id;
  final String number;
  final Unit unit;
  final Account owner;
  final List<ParkingRegistration> parkingRegistrations;

  Map<String, dynamic> toJson() => _$AccessCardToJson(this);
}
