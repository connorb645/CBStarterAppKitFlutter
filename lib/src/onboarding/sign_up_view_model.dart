import 'package:cb_app_starter_kit/cb_app_starter_kit.dart';
import 'package:cb_app_starter_kit/src/helpers/validators.dart';
import 'package:flutter/material.dart';

enum SignUpFormType { signIn, signUp }

class SignUpViewModel
    with
        EmailValidator,
        PasswordValidator,
        ConfirmPasswordValidator,
        ChangeNotifier {
  final AuthBase auth;
  String email = "";
  String password = "";
  String confirmPassword = "";
  SignUpFormType formType = SignUpFormType.signUp;
  bool submitted = false;
  bool loading = false;

  SignUpViewModel({required this.auth});

  String get title {
    return this.formType == SignUpFormType.signUp ? "Create Account" : "Log In";
  }

  String get buttonTitle {
    return this.formType == SignUpFormType.signUp
        ? "Create my account"
        : "Let's go!";
  }

  String get formToggleButtonTitle {
    return this.formType == SignUpFormType.signUp
        ? "Already have an account? Log in!"
        : "Don't have an account? Create one!";
  }

  String? get emailErrorText {
    bool showError = !isEmailValid(this.email) && submitted;
    return showError ? invalidEmailErrorText(this.email) : null;
  }

  String? get passwordErrorText {
    bool showError =
        !this.passwordValidator.isValid(this.password) && submitted;
    return showError ? invalidPasswordErrorText : null;
  }

  String? get confirmPasswordErrorText {
    bool showError = !this
            .confirmPasswordValidator
            .isValid(this.password, this.confirmPassword) &&
        submitted;
    return showError ? invalidConfirmPasswordErrorText : null;
  }

  Future<bool> submit(BuildContext context) async {
    update(submitted: true);
    try {
      if (formType == SignUpFormType.signUp) {
        await auth.createUserWithEmailAndPassword(email, password);
      } else {
        await auth.signInWithEmailAndPassword(email, password);
      }
      return true;
    } on Exception catch (e) {
      showErrorAlertDialog(context,
          title: "Error creating your account", exception: e);
      return false;
    }
  }

  void toggleFormType() {
    update(
        formType: this.formType == SignUpFormType.signUp
            ? SignUpFormType.signIn
            : SignUpFormType.signUp,
        submitted: false);
  }

  void update(
      {String? email,
      String? password,
      String? confirmPassword,
      SignUpFormType? formType,
      bool? submitted}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.confirmPassword = confirmPassword ?? this.confirmPassword;
    this.formType = formType ?? this.formType;
    this.submitted = submitted ?? this.submitted;

    notifyListeners();
  }

  void updateEmail(String email) => update(email: email);

  void updatePassword(String password) => update(password: password);

  void updateConfirmPassword(String confirmPassword) =>
      update(confirmPassword: confirmPassword);
}
