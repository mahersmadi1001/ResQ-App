import 'package:flutter/material.dart';
import 'package:projct/viwe/onbording_pages/onbording_custom.dart';
import 'package:projct/viwe/sign_up/signup_screen.dart';

class OnBordingPageView extends StatelessWidget {
  OnBordingPageView({super.key});
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        OnbordingPage(
          isFoundBack: false,
          controller: controller,
          isFoundSkipe: true,
          imagePath: "images/onbording1.png",
          discrabtion:
              "In any case or at any time, let us know... we will be with you",
          textButton: "Next",
          ontap: () {
            controller.animateToPage(
              1,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          },
        ),
        OnbordingPage(
          isFoundBack: true,
          ontapBack: () {
            controller.animateToPage(
              0,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          },
          controller: controller,
          ontap: () {
            controller.animateToPage(
              2,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          },
          isFoundSkipe: true,
          imagePath: "images/onbording2.png",
          discrabtion:
              "In any case or at any time, let us know... we will be with you",
          textButton: "Next",
        ),
        OnbordingPage(
          isFoundBack: true,
          ontapBack: () {
            controller.animateToPage(
              1,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          },
          controller: controller,
          ontap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignupScreen();
                },
              ),
            );
          },
          isFoundSkipe: false,
          imagePath: "images/onbording3.png",
          discrabtion:
              "In any case or at any time, let us know... we will be with you",
          textButton: "Go",
        ),
      ],
    );
  }
}
