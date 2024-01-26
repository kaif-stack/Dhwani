import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key,required this.controller});
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
                "आकलन की प्रक्रिया",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff04434E),
                  fontFamily: "NotoSansDevanagari",
                ),
              ),
            ),
            Stack(
              children: [
                const Center(child: Image(image: AssetImage("assets/onboarding/img1.png"))),
                Image(
                    image: const AssetImage("assets/onboarding/lightback.png"),
                    width: screenWidth,
                    fit: BoxFit.fitWidth
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 350, left: 110, right: 110),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image(image: AssetImage("assets/onboarding/Hand1.png")),
                          SizedBox(height: 20),
                          Image(image: AssetImage("assets/onboarding/Hand2.png")),
                          SizedBox(height: 20),
                          Image(image: AssetImage("assets/onboarding/Hand3.png")),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "स्वयं उत्तर दें।",
                            style: TextStyle(
                              letterSpacing: 0.7,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: "NotoSansDevanagari",
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "जलदबाज़ी न करें।",
                            style: TextStyle(
                              letterSpacing: 0.7,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: "NotoSansDevanagari",
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "निजी रिपोर्ट पाएं।",
                            style: TextStyle(
                              letterSpacing: 0.7,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: "NotoSansDevanagari",
                            ),
                          ),
                        ],
                      ),
                    ],
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
                              activeDotColor: Color(0xff04434E),
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
