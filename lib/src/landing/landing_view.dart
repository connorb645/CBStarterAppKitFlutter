import 'package:cb_app_starter_kit/src/models/landing_view_options.dart';
import 'package:flutter/material.dart';
import '../../cb_app_starter_kit.dart';
import 'sign_in_options_view.dart';

class LandingView extends StatelessWidget {
  final LandingViewOptions options;
  final void Function() signInWithGoogleTapped;
  final void Function() signInWithEmailAndPasswordTapped;

  const LandingView({
    Key? key,
    required this.options,
    required this.signInWithGoogleTapped,
    required this.signInWithEmailAndPasswordTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInOptionsView(
      landingViewOptions: options,
      signInWithGoogleTapped: signInWithGoogleTapped,
      signInWithEmailAndPasswordTapped: signInWithEmailAndPasswordTapped,
    );
  }
}
