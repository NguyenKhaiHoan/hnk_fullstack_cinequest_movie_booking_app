import 'package:cinequest/src/core/extensions/string_extension.dart';

class ValidationUtil {
  ValidationUtil._();

  static String? validateEmptyField(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.'.hardcoded;
    }
    return null;
  }

  static String? validateEmail(String fieldName, String? value) {
    validateEmptyField('Email', value);

    final emailRegExp = RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (!emailRegExp.hasMatch(value!)) {
      return 'Invalid email address.'.hardcoded;
    }
    return null;
  }

  static String? validatePassword(String fieldName, String? value) {
    validateEmptyField(fieldName, value);

    if (value!.length < 8) {
      return 'Password must be at least 8 characters long.'.hardcoded;
    }

    if (!value.contains(RegExp('[0-9]'))) {
      return 'Password must contain at least 1 numeric character.'.hardcoded;
    }

    if (!value.contains(RegExp('[A-Z]'))) {
      return 'Password must contain at least 1 uppercase letter.'.hardcoded;
    }

    if (!value.contains(RegExp(r'[@%/\+!#$^)(~_ ,.?]'))) {
      return 'Password must contain at least 1 special character.'.hardcoded;
    }
    return null;
  }

  static String? validateCorrectPassword(
    String fieldName,
    String? value,
    String password,
  ) {
    validatePassword(fieldName, value);
    if (value!.trim() != password.trim()) {
      return 'Passwords do not match.'.hardcoded;
    }
    return null;
  }

  static String? validatePhoneNumber(String fieldName, String? value) {
    validateEmptyField(fieldName, value);

    final phoneNumberRegExp = RegExp(
      r'^(0|84)(2(0[3-9]|1[0-6|8|9]|2[0-2|5-9]|3[2-9]|4[0-9]|5[1|2|4-9]|6[0-3|9]|7[0-7]|8[0-9]|9[0-4|6|7|9])|3[2-9]|5[5|6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])([0-9]{7})$',
    );

    if (!phoneNumberRegExp.hasMatch(value!)) {
      return 'Invalid phone number.'.hardcoded;
    }
    return null;
  }
}
