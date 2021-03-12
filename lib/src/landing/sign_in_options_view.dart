import 'package:cb_app_starter_kit/src/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';

import '../../cb_app_starter_kit.dart';

class SignInOptionsView extends StatelessWidget {
  final LandingViewOptions landingViewOptions;
  final void Function() signInWithGoogleTapped;
  final void Function() signInWithEmailAndPasswordTapped;

  const SignInOptionsView(
      {Key? key,
      required this.landingViewOptions,
      required this.signInWithGoogleTapped,
      required this.signInWithEmailAndPasswordTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        top: false,
        child: Container(
          color: Colors.indigo,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildMainContent(context),
              buildButtonContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMainContent(BuildContext context) {
    return Expanded(
      child: OnboardingView(
        options: landingViewOptions,
      ),
    );
  }

  Widget buildButtonContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 32),
        child: Column(
          children: [
            CBButton(
              title: "Sign in with Google",
              backgroundColor: Colors.red,
              onPressed: signInWithGoogleTapped,
            ),
            CBButton(
              title: "Sign in with email / password",
              onPressed: signInWithEmailAndPasswordTapped,
            ),
          ],
        ),
      ),
    );
  }
}
