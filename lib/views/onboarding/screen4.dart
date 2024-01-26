import 'package:dhwani/views/dhwani_main/dhwani_screen.dart';
import 'package:flutter/material.dart';

class LastScreen extends StatelessWidget {
  const LastScreen({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 60, right: 60),
              child: Text(
                "क्या आप तैयार हैं?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff04434E),
                  fontFamily: "NotoSansDevanagari",
                ),
              ),
            ),
            const SizedBox(height: 90),
            const Center(
                child: Image(image: AssetImage("assets/onboarding/img4.png"))),
            const SizedBox(height: 100),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff04434E),
                    offset: Offset(8, 8), // Shadow position: right and bottom
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ElevatedButton(
                  onPressed: () {
                   
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0CC0DF),
                    padding: const EdgeInsets.only(
                        left: 80, right: 80, top: 14, bottom: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "प्रारंभ करें",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: "NotoSansDevanagari",
                    ),
                  )),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                              color: const Color(
                                  0xff04434E)) // Change the color as needed
                          ),
                      padding:
                          const EdgeInsets.all(8), // Adjust padding as needed
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xff04434E), // Change the color as needed
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
