import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key,required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(
                "अपनी कमियां जानें",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0CC0DF),
                  fontFamily: "NotoSansDevanagari",
                ),
              ),
            ),
            Stack(
              children: [
                const Center(child: Image(image: AssetImage("assets/onboarding/img3.png"))),
                Image(
                    image: const AssetImage("assets/onboarding/darkback.png"),
                    width: screenWidth,
                    fit: BoxFit.fitWidth
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 350,left: 40,right: 40),
                  child: Text(
                    "आपको बोलने के परीक्षण प्रश्न दिये जायेंगे, जो देखेंगे कि आपकी बोली कैसी है। इससे पता चलेगा कि आप कहाँ सुधार कर सकते हैं।",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 0.7,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "NotoSansDevanagari",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 500,left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            controller.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }, 
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white
                              )// Change the color as needed
                            ),
                            padding: const EdgeInsets.all(8), // Adjust padding as needed
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white, // Change the color as needed
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }, 
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white
                              )// Change the color as needed
                            ),
                            padding: const EdgeInsets.all(8), // Adjust padding as needed
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white, // Change the color as needed
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 19,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 150,right: 150),
                     child: Center(
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: 4,
                          effect: const WormEffect(
                              spacing: 10,
                              dotColor: Colors.white,
                              activeDotColor: Color(0xff0CC0DF),
                              dotHeight: 10,
                              dotWidth: 10
                          ),
                          onDotClicked: (index)=> controller.animateToPage(
                            index, 
                            duration: const Duration(milliseconds: 500), 
                            curve: Curves.easeIn
                          ),
                        ),
                      ),
                   ),
                 )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
