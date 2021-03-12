abstract class StringValidator {
  bool isValid(String value);
}

abstract class StringsEqualValidator {
  bool isValid(String value1, String value2);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class AppropriateEmailValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}

class SecurePasswordValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.length >= 6;
  }
}

class EqualStringsValidator implements StringsEqualValidator {
  @override
  bool isValid(String value1, String value2) {
    return value1 == value2;
  }
}

class EmailValidator {
  final StringValidator emailNonEmptyValidator = NonEmptyStringValidator();
  final StringValidator emailAppropriateValidator = AppropriateEmailValidator();

  bool isEmailValid(String value) {
    return emailNonEmptyValidator.isValid(value) &&
        emailAppropriateValidator.isValid(value);
  }

  String invalidEmailErrorText(String value) {
    if (!emailNonEmptyValidator.isValid(value)) {
      return "Email address field cannot be empty.";
    } else if (!emailAppropriateValidator.isValid(value)) {
      return "Email address is invalid.";
    }
    return "There is an unknown problem with the entered email address.";
  }
}

class PasswordValidator {
  final StringValidator passwordValidator = SecurePasswordValidator();
  final String invalidPasswordErrorText = "Password is not secure enough.";
}

class ConfirmPasswordValidator {
  final StringsEqualValidator confirmPasswordValidator =
      EqualStringsValidator();
  final String invalidConfirmPasswordErrorText = "Passwords do not match.";
}
