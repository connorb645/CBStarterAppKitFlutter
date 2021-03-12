import 'package:cb_app_starter_kit/src/models/landing_view_options.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  final LandingViewOptions options;

  const OnboardingView({
    Key key,
    @required this.options,
  }) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      PageView(
        controller: _pageController,
        children: [
          buildItem(context, widget.options.titleOne,
              widget.options.descriptionOne, widget.options.imageOne),
          buildItem(context, widget.options.titleTwo,
              widget.options.descriptionTwo, widget.options.imageTwo),
          buildItem(context, widget.options.titleThree,
              widget.options.descriptionThree, widget.options.imageThree),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SmoothPageIndicator(
          controller: _pageController,
          count: 3,
          effect: WormEffect(
            activeDotColor: Colors.white,
            dotColor: Colors.grey[400],
            dotHeight: 8.0,
            dotWidth: 8.0,
          ),
        ),
      )
    ]);
  }

  Widget buildItem(BuildContext context, String title, String description,
      String imageName) {
    return Container(
      color: widget.options.backgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imageName),
              SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: TextStyle(
                  color: widget.options.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                description,
                style: TextStyle(
                  color: widget.options.textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
