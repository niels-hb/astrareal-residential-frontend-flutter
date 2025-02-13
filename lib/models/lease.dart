import 'package:json_annotation/json_annotation.dart';

import 'account.dart';
import 'unit.dart';

part 'lease.g.dart';

@JsonSerializable()
class Lease {
  Lease({
    this.id,
    required this.lessor,
    required this.lessee,
    required this.leaseStart,
    required this.leaseEnd,
    required this.rentalFee,
    required this.leaseTerms,
    required this.unit,
  });

  factory Lease.fromJson(Map<String, dynamic> json) => _$LeaseFromJson(json);

  final String? id;
  final Account lessor;
  final Account lessee;
  final DateTime leaseStart;
  final DateTime leaseEnd;
  final int rentalFee;
  final String leaseTerms;
  final Unit unit;

  Map<String, dynamic> toJson() => _$LeaseToJson(this);
}
