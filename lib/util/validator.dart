import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/country.dart';
import '../models/nationality.dart';

class Validator {
  Validator._internal(this.context);

  factory Validator.of(BuildContext context) => Validator._internal(context);

  static final RegExp _emailRegExp = RegExp(
    r'''^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$''',
  );
  static final RegExp _telephoneNumberRegExp = RegExp(
    r'^[\+]?[0-9]{9,13}$',
  );

  final BuildContext context;

  List<ValidationResult> requiredFieldValidator(
    String? value, [
    ValidationResult resultIfMissing = ValidationResult.requiredFieldMissing,
  ]) {
    if (value?.isEmpty ?? true) {
      return <ValidationResult>[resultIfMissing];
    }

    return <ValidationResult>[];
  }

  List<ValidationResult> regexValidator(
    String? value,
    RegExp regExp,
    ValidationResult? resultIfMissing,
    ValidationResult resultIfInvalid,
  ) {
    final List<ValidationResult> validationResults = <ValidationResult>[];

    if (requiredFieldValidator(value).isNotEmpty) {
      return resultIfMissing == null
          ? <ValidationResult>[]
          : <ValidationResult>[resultIfMissing];
    }

    if (!regExp.hasMatch(value!)) {
      validationResults.add(resultIfInvalid);
    }

    return validationResults;
  }

  List<ValidationResult> emailValidator(
    String? email,
  ) {
    return regexValidator(
      email,
      _emailRegExp,
      ValidationResult.emailMissing,
      ValidationResult.emailInvalid,
    );
  }

  List<ValidationResult> telephoneNumberValidator(
    String? telephoneNumber, {
    bool required = true,
  }) {
    if (!required && (telephoneNumber?.isEmpty ?? false)) {
      return <ValidationResult>[];
    }

    return regexValidator(
      telephoneNumber,
      _telephoneNumberRegExp,
      ValidationResult.telephoneNumberMissing,
      ValidationResult.telephoneNumberInvalid,
    );
  }

  List<ValidationResult> usernameValidator(String? username) {
    final List<ValidationResult> validationResults = <ValidationResult>[];

    validationResults.addAll(
      requiredFieldValidator(
        username,
        ValidationResult.usernameMissing,
      ),
    );

    if (emailValidator(username).isNotEmpty &&
        telephoneNumberValidator(username).isNotEmpty) {
      validationResults.add(ValidationResult.usernameInvalid);
    }

    return validationResults;
  }

  List<ValidationResult> passwordValidator(
    String? password,
  ) {
    return requiredFieldValidator(password, ValidationResult.passwordMissing);
  }

  List<ValidationResult> passwordConfirmationValidator(
    String? password,
    String? passwordConfirmation,
  ) {
    final List<ValidationResult> validationResults = <ValidationResult>[];

    validationResults.addAll(passwordValidator(password));
    validationResults.addAll(passwordValidator(passwordConfirmation));

    if (password != passwordConfirmation) {
      validationResults.add(ValidationResult.passwordConfirmationMismatch);
    }

    return validationResults;
  }

  List<ValidationResult> nationalityValidator(
    String? nationality,
  ) {
    final List<ValidationResult> validationResults = <ValidationResult>[];

    validationResults.addAll(requiredFieldValidator(
      nationality,
      ValidationResult.nationalityMissing,
    ));

    if (nationalityFromTranslation(context, nationality) == null) {
      validationResults.add(ValidationResult.nationalityInvalid);
    }

    return validationResults;
  }

  List<ValidationResult> countryValidator(
    String? country,
  ) {
    final List<ValidationResult> validationResults = <ValidationResult>[];

    validationResults.addAll(requiredFieldValidator(country));

    if (countryFromTranslation(context, country) == null) {
      validationResults.add(ValidationResult.countryInvalid);
    }

    return validationResults;
  }

  List<ValidationResult> positiveNumber(
    String? number, {
    bool decimal = false,
  }) {
    final List<ValidationResult> validationResults = <ValidationResult>[];

    validationResults.addAll(requiredFieldValidator(number));

    try {
      if (decimal) {
        final double result = double.parse(number!);

        if (result <= 0) {
          validationResults.add(ValidationResult.nonPositiveNumber);
        }
      } else {
        final int result = int.parse(number!);

        if (result <= 0) {
          validationResults.add(ValidationResult.nonPositiveNumber);
        }
      }
    } catch (e) {
      validationResults.add(ValidationResult.invalidNumber);
    }

    return validationResults;
  }

  List<ValidationResult> requiredListValidator<T>(
    List<T>? list, [
    ValidationResult resultIfEmpty = ValidationResult.listMustNotBeEmpty,
  ]) {
    return list?.isEmpty ?? true
        ? <ValidationResult>[resultIfEmpty]
        : <ValidationResult>[];
  }

  String? getErrorMessage({
    required List<ValidationResult> Function(Validator) validationResults,
  }) {
    for (final ValidationResult validationResult in validationResults(this)) {
      return validationResult.getErrorMessage(context);
    }

    return null;
  }
}

enum ValidationResult {
  requiredFieldMissing,
  passwordMissing,
  passwordConfirmationMismatch,
  usernameMissing,
  usernameInvalid,
  emailInvalid,
  emailMissing,
  telephoneNumberMissing,
  telephoneNumberInvalid,
  nameMissing,
  dateOfBirthMissing,
  nationalityMissing,
  nationalityInvalid,
  countryInvalid,
  addressMissing,
  identificationMissing,
  invalidNumber,
  nonPositiveNumber,
  listMustNotBeEmpty
}

extension on ValidationResult {
  String getErrorMessage(BuildContext context) {
    switch (this) {
      case ValidationResult.requiredFieldMissing:
        return AppLocalizations.of(context)!.requiredFieldMissing;
      case ValidationResult.passwordMissing:
        return AppLocalizations.of(context)!.passwordRequired;
      case ValidationResult.passwordConfirmationMismatch:
        return AppLocalizations.of(context)!.passwordAndConfirmationDontMatch;
      case ValidationResult.usernameMissing:
        return AppLocalizations.of(context)!.emailOrTelephoneNumberRequired;
      case ValidationResult.usernameInvalid:
        return AppLocalizations.of(context)!.emailOrTelephoneNumberInvalid;
      case ValidationResult.emailInvalid:
        return AppLocalizations.of(context)!.emailInvalid;
      case ValidationResult.emailMissing:
        return AppLocalizations.of(context)!.emailRequired;
      case ValidationResult.telephoneNumberMissing:
        return AppLocalizations.of(context)!.telephoneNumberRequired;
      case ValidationResult.telephoneNumberInvalid:
        return AppLocalizations.of(context)!.telephoneNumberInvalid;
      case ValidationResult.nameMissing:
        return AppLocalizations.of(context)!.nameRequired;
      case ValidationResult.dateOfBirthMissing:
        return AppLocalizations.of(context)!.dateOfBirthRequired;
      case ValidationResult.nationalityMissing:
        return AppLocalizations.of(context)!.nationalityRequired;
      case ValidationResult.nationalityInvalid:
        return AppLocalizations.of(context)!.nationalityInvalid;
      case ValidationResult.countryInvalid:
        return AppLocalizations.of(context)!.countryInvalid;
      case ValidationResult.addressMissing:
        return AppLocalizations.of(context)!.addressRequired;
      case ValidationResult.identificationMissing:
        return AppLocalizations.of(context)!.identificationRequired;
      case ValidationResult.invalidNumber:
        return AppLocalizations.of(context)!.numberInvalid;
      case ValidationResult.nonPositiveNumber:
        return AppLocalizations.of(context)!.numberMustBePositive;
      case ValidationResult.listMustNotBeEmpty:
        return AppLocalizations.of(context)!.listMayNotBeEmpty;
    }
  }
}
