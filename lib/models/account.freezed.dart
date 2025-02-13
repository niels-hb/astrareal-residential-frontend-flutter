// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
mixin _$Account {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get telephoneNumber => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  AccountType get type => throw _privateConstructorUsedError;
  Nationality? get nationality => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  Gender? get gender => throw _privateConstructorUsedError;
  Address? get permanentResidentialAddress =>
      throw _privateConstructorUsedError;
  Identification? get identification => throw _privateConstructorUsedError;
  String? get idNumber => throw _privateConstructorUsedError;
  String? get taxIdNumber => throw _privateConstructorUsedError;
  Address? get registeredAddress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String email,
      String telephoneNumber,
      String? password,
      AccountType type,
      Nationality? nationality,
      DateTime? dateOfBirth,
      Gender? gender,
      Address? permanentResidentialAddress,
      Identification? identification,
      String? idNumber,
      String? taxIdNumber,
      Address? registeredAddress});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? email = null,
    Object? telephoneNumber = null,
    Object? password = freezed,
    Object? type = null,
    Object? nationality = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? permanentResidentialAddress = freezed,
    Object? identification = freezed,
    Object? idNumber = freezed,
    Object? taxIdNumber = freezed,
    Object? registeredAddress = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      telephoneNumber: null == telephoneNumber
          ? _value.telephoneNumber
          : telephoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AccountType,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as Nationality?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      permanentResidentialAddress: freezed == permanentResidentialAddress
          ? _value.permanentResidentialAddress
          : permanentResidentialAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      identification: freezed == identification
          ? _value.identification
          : identification // ignore: cast_nullable_to_non_nullable
              as Identification?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      taxIdNumber: freezed == taxIdNumber
          ? _value.taxIdNumber
          : taxIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      registeredAddress: freezed == registeredAddress
          ? _value.registeredAddress
          : registeredAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$_AccountCopyWith(
          _$_Account value, $Res Function(_$_Account) then) =
      __$$_AccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String email,
      String telephoneNumber,
      String? password,
      AccountType type,
      Nationality? nationality,
      DateTime? dateOfBirth,
      Gender? gender,
      Address? permanentResidentialAddress,
      Identification? identification,
      String? idNumber,
      String? taxIdNumber,
      Address? registeredAddress});
}

/// @nodoc
class __$$_AccountCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$_Account>
    implements _$$_AccountCopyWith<$Res> {
  __$$_AccountCopyWithImpl(_$_Account _value, $Res Function(_$_Account) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? email = null,
    Object? telephoneNumber = null,
    Object? password = freezed,
    Object? type = null,
    Object? nationality = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? permanentResidentialAddress = freezed,
    Object? identification = freezed,
    Object? idNumber = freezed,
    Object? taxIdNumber = freezed,
    Object? registeredAddress = freezed,
  }) {
    return _then(_$_Account(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      telephoneNumber: null == telephoneNumber
          ? _value.telephoneNumber
          : telephoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AccountType,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as Nationality?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      permanentResidentialAddress: freezed == permanentResidentialAddress
          ? _value.permanentResidentialAddress
          : permanentResidentialAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      identification: freezed == identification
          ? _value.identification
          : identification // ignore: cast_nullable_to_non_nullable
              as Identification?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      taxIdNumber: freezed == taxIdNumber
          ? _value.taxIdNumber
          : taxIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      registeredAddress: freezed == registeredAddress
          ? _value.registeredAddress
          : registeredAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Account with DiagnosticableTreeMixin implements _Account {
  const _$_Account(
      {this.id,
      required this.name,
      required this.email,
      required this.telephoneNumber,
      this.password,
      required this.type,
      this.nationality,
      this.dateOfBirth,
      this.gender,
      this.permanentResidentialAddress,
      this.identification,
      this.idNumber,
      this.taxIdNumber,
      this.registeredAddress});

  factory _$_Account.fromJson(Map<String, dynamic> json) =>
      _$$_AccountFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String telephoneNumber;
  @override
  final String? password;
  @override
  final AccountType type;
  @override
  final Nationality? nationality;
  @override
  final DateTime? dateOfBirth;
  @override
  final Gender? gender;
  @override
  final Address? permanentResidentialAddress;
  @override
  final Identification? identification;
  @override
  final String? idNumber;
  @override
  final String? taxIdNumber;
  @override
  final Address? registeredAddress;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Account(id: $id, name: $name, email: $email, telephoneNumber: $telephoneNumber, password: $password, type: $type, nationality: $nationality, dateOfBirth: $dateOfBirth, gender: $gender, permanentResidentialAddress: $permanentResidentialAddress, identification: $identification, idNumber: $idNumber, taxIdNumber: $taxIdNumber, registeredAddress: $registeredAddress)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Account'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('telephoneNumber', telephoneNumber))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('nationality', nationality))
      ..add(DiagnosticsProperty('dateOfBirth', dateOfBirth))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty(
          'permanentResidentialAddress', permanentResidentialAddress))
      ..add(DiagnosticsProperty('identification', identification))
      ..add(DiagnosticsProperty('idNumber', idNumber))
      ..add(DiagnosticsProperty('taxIdNumber', taxIdNumber))
      ..add(DiagnosticsProperty('registeredAddress', registeredAddress));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Account &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.telephoneNumber, telephoneNumber) ||
                other.telephoneNumber == telephoneNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.permanentResidentialAddress,
                    permanentResidentialAddress) ||
                other.permanentResidentialAddress ==
                    permanentResidentialAddress) &&
            (identical(other.identification, identification) ||
                other.identification == identification) &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.taxIdNumber, taxIdNumber) ||
                other.taxIdNumber == taxIdNumber) &&
            (identical(other.registeredAddress, registeredAddress) ||
                other.registeredAddress == registeredAddress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      telephoneNumber,
      password,
      type,
      nationality,
      dateOfBirth,
      gender,
      permanentResidentialAddress,
      identification,
      idNumber,
      taxIdNumber,
      registeredAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountCopyWith<_$_Account> get copyWith =>
      __$$_AccountCopyWithImpl<_$_Account>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccountToJson(
      this,
    );
  }
}

abstract class _Account implements Account {
  const factory _Account(
      {final String? id,
      required final String name,
      required final String email,
      required final String telephoneNumber,
      final String? password,
      required final AccountType type,
      final Nationality? nationality,
      final DateTime? dateOfBirth,
      final Gender? gender,
      final Address? permanentResidentialAddress,
      final Identification? identification,
      final String? idNumber,
      final String? taxIdNumber,
      final Address? registeredAddress}) = _$_Account;

  factory _Account.fromJson(Map<String, dynamic> json) = _$_Account.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get telephoneNumber;
  @override
  String? get password;
  @override
  AccountType get type;
  @override
  Nationality? get nationality;
  @override
  DateTime? get dateOfBirth;
  @override
  Gender? get gender;
  @override
  Address? get permanentResidentialAddress;
  @override
  Identification? get identification;
  @override
  String? get idNumber;
  @override
  String? get taxIdNumber;
  @override
  Address? get registeredAddress;
  @override
  @JsonKey(ignore: true)
  _$$_AccountCopyWith<_$_Account> get copyWith =>
      throw _privateConstructorUsedError;
}
