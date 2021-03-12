import 'package:flutter/material.dart';

class LandingViewOptions {
  final Color backgroundColor;
  final Color textColor;
  final String titleOne;
  final String titleTwo;
  final String titleThree;
  final String descriptionOne;
  final String descriptionTwo;
  final String descriptionThree;
  final String imageOne;
  final String imageTwo;
  final String imageThree;

  LandingViewOptions({
    this.backgroundColor = Colors.deepPurple,
    this.textColor = Colors.white,
    required this.titleOne,
    required this.titleTwo,
    required this.titleThree,
    required this.descriptionOne,
    required this.descriptionTwo,
    required this.descriptionThree,
    this.imageOne = "assets/images/onboarding-placeholder-1.png",
    this.imageTwo = "assets/images/onboarding-placeholder-2.png",
    this.imageThree = "assets/images/onboarding-placeholder-3.png",
  });
}
