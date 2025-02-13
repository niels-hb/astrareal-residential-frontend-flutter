import 'package:json_annotation/json_annotation.dart';

import 'account.dart';
import 'account_email.dart';
import 'unit.dart';

part 'create_lease_request.g.dart';

@JsonSerializable()
class CreateLeaseRequest {
  CreateLeaseRequest({
    this.id,
    required this.lessor,
    required this.lessee,
    required this.leaseStart,
    required this.leaseEnd,
    required this.leaseTerms,
    required this.rentalFee,
    required this.unit,
  });

  factory CreateLeaseRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLeaseRequestFromJson(json);

  final String? id;
  final Account lessor;
  final AccountEmail lessee;
  final DateTime leaseStart;
  final DateTime leaseEnd;
  final int rentalFee;
  final String leaseTerms;
  final Unit unit;

  Map<String, dynamic> toJson() => _$CreateLeaseRequestToJson(this);
}
