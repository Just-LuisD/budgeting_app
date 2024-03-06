import 'package:budgeting_app/widgets/onboarding/fifth_page.dart';
import 'package:budgeting_app/widgets/onboarding/first_page.dart';
import 'package:budgeting_app/widgets/onboarding/fourth_page.dart';
import 'package:budgeting_app/widgets/onboarding/second_page.dart';
import 'package:budgeting_app/widgets/onboarding/third_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: pageController,
          children: [
            FirstPage(),
            SecondPage(),
            ThirdPage(),
            FourthPage(),
            FifthPage(),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: SlideEffect(
                activeDotColor: Color.fromARGB(255, 103, 65, 136),
                dotColor: Color.fromARGB(255, 195, 172, 208),
              ),
            )),
      ]),
    );
  }
}
