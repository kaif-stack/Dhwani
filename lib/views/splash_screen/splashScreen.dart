import 'package:dhwani/views/routes_view/routeview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  static const routename = '/splashscreen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Material(
      color: const Color(0xffE6F4F1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(30.0),
            child: const Image(
              image: AssetImage("assets/Logo.png"),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
              height: 30.0), // Adjust the space between the image and text
          Text(
            'Dhwani',
            style: TextStyle(
              fontFamily: GoogleFonts.berkshireSwash().fontFamily,
              fontSize: 60.0, // Adjust the font size as needed
              fontWeight: FontWeight.w400,
              color: const Color(0xff04434E), // Adjust the text color as needed
            ),
          ),
        ],
      ),
    );
  }
}
