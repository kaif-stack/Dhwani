import 'package:dhwani/views/onboarding/screen1.dart';
import 'package:dhwani/views/onboarding/screen2.dart';
import 'package:dhwani/views/onboarding/screen3.dart';
import 'package:dhwani/views/onboarding/screen4.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const routename = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          FirstScreen(controller: controller),
          SecondScreen(controller: controller),
          ThirdScreen(controller: controller),
          LastScreen(controller: controller)
        ],
      ),
      // bottomSheet: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   height: 80,
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           TextButton(
      //             onPressed: () {
      //               controller.previousPage(
      //                   duration: const Duration(milliseconds: 500),
      //                   curve: Curves.easeInOut);
      //             },
      //             child: const Text('Prev')
      //           ),
      //           TextButton(
      //               onPressed: () {
      //                 controller.nextPage(
      //                     duration: const Duration(milliseconds: 500),
      //                     curve: Curves.easeInOut);
      //               },
      //               child: const Text('Next'))
      //         ],
      //       ),
      //       Center(
      //         child: SmoothPageIndicator(
      //           controller: controller,
      //           count: 3,
      //           effect: WormEffect(
      //               spacing: 16,
      //               dotColor: Colors.black26,
      //               activeDotColor: Colors.teal.shade200
      //           ),
      //           onDotClicked: (index)=> controller.animateToPage(
      //             index,
      //             duration: const Duration(milliseconds: 500),
      //             curve: Curves.easeIn
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
