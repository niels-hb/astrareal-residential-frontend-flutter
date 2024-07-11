import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_type.dart';
import 'address.dart';
import 'gender.dart';
import 'identification.dart';
import 'nationality.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@Freezed()
class Account with _$Account {
  const factory Account({
    String? id,
    required String name,
    required String email,
    required String telephoneNumber,
    String? password,
    required AccountType type,
    Nationality? nationality,
    DateTime? dateOfBirth,
    Gender? gender,
    Address? permanentResidentialAddress,
    Identification? identification,
    String? idNumber,
    String? taxIdNumber,
    Address? registeredAddress,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
