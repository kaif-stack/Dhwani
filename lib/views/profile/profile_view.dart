import 'package:carbon_icons/carbon_icons.dart';
import 'package:dhwani/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerWidget {
  static const routename = '/profile';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    int streak = 5;
    int modulesComplete = 15;
    int timeSpent = 27;
    int chaptersCompleted = 5;

    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Material(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xffE6F4F1),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff04434E),
                            fontWeight: FontWeight.w700),
                      ),
                      Icon(CarbonIcons.settings, color: Color(0xff04434E))
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xff04434E),
                  width: screenWidth,
                  height: 2,
                ),
                Center(
                    child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(children: [
                          const CircleAvatar(
                            radius: 80.0,
                            backgroundImage: AssetImage(
                                'assets/chand2.png'), // Add your image asset path
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff0CC0DF)),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]))),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Utkarsh Ahuja",
                      style: TextStyle(
                          letterSpacing: 0.9,
                          fontSize: 34,
                          color: Color(0xff0CC0DF),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(12, 192, 223, 0.08),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 40, right: 40, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Statistics",
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontSize: 25,
                                color: Color(0xff04434E),
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatsContainer(
                              type: "Streak",
                            ),
                            StatsContainer(
                              type: "Module",
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatsContainer(
                              type: "Time",
                            ),
                            StatsContainer(
                              type: "Test",
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 40, right: 40, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("उपलब्धियों",
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontSize: 25,
                                color: Color(0xff04434E),
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BadgeContainer(
                              type: "Welcome",
                            ),
                            BadgeContainer(
                              type: "Module",
                            ),
                            BadgeContainer(
                              type: "Time",
                            ),
                            BadgeContainer(
                              type: "Test",
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                 Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: screenWidth,
                  child: const Padding(
                    padding:  EdgeInsets.only(
                        top: 10, left: 40, right: 40, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("परीक्षा के अंक",
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontSize: 25,
                                color: Color(0xff04434E),
                                fontWeight: FontWeight.w600)),
                         SizedBox(height: 10),
                        Image(image: AssetImage("assets/Testchart.png"))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))),
    );
  }
}

class StatsContainer extends StatelessWidget {
  StatsContainer({Key? key, required this.type});
  String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffD9D9D9),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image(
              image: (type == "Streak")
                  ? const AssetImage("assets/profile/Streak.png")
                  : (type == "Module")
                      ? const AssetImage("assets/profile/Module.png")
                      : (type == "Time")
                          ? const AssetImage("assets/profile/Clock.png")
                          : const AssetImage("assets/profile/Test.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("5",
                        style: TextStyle(
                            letterSpacing: 0.9,
                            fontSize: 20,
                            color: Color(0xff0CC0DF),
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(
                        (type == "Streak")
                            ? "स्ट्रीक"
                            : (type == "Module")
                                ? "अध्याय समाप्त"
                                : (type == "Time")
                                    ? "समय बिताया "
                                    : "परीक्षा समाप्त",
                        style: const TextStyle(
                            fontSize: 15,
                            fontFamily: "NotoSansDevanagari",
                            color: Color(0xff9A9A9A),
                            fontWeight: FontWeight.w600)),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}


class BadgeContainer extends StatelessWidget {
  BadgeContainer({Key? key, required this.type});
  String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 80,
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image(
              image: (type == "Welcome")
                  ? const AssetImage("assets/profile/Welcome.png")
                  : (type == "Module")
                      ? const AssetImage("assets/profile/Modules.png")
                      : (type == "Test")
                          ? const AssetImage("assets/profile/TestBadge.png")
                          : const AssetImage("assets/profile/TimeBadge.png"),
            ),
      ),
    );
  }
}