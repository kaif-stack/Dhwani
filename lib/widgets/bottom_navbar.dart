import 'package:carbon_icons/carbon_icons.dart';
import 'package:dhwani/routes/app_route_config.dart';
import 'package:dhwani/views/dhwani_main/dhwani_screen.dart';
import 'package:dhwani/views/mock/mock_view.dart';
import 'package:dhwani/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends ConsumerWidget {
  const BottomNavbar({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomAppBar(
        height: 57,
        color: const Color(0xffE6FAFD),
        elevation: 0,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  if (index != 0) {
                    ref.read(routerProvider).go(DhwaniScreen.routename);
                  }
                },
                child: Icon(
                  Icons.home,
                  size: 40,
                  color: (index == 0)
                      ? const Color(0xff04434E)
                      : const Color(0xff0CC0DF),
                ),
              ),
              // InkWell(
              //     onTap: () {
              //       if (screen != "Dhwani") {
              //         GoRouter.of(context).pushNamed("Dhwani Screen");
              //       }
              //     },
              //     child: (screen == "Dhwani")
              //         ? const Image(
              //             image: AssetImage("assets/dhwaninavdark.png"))
              //         : const Image(
              //             image: AssetImage("assets/dhwaninavlight.png"))),
              InkWell(
                onTap: () {
                  if (index != 1) {
                    ref.read(routerProvider).go(MockView.routename);
                  }
                },
                child: (index == 1)
                    ? const Image(image: AssetImage("assets/mocknavdark.png"))
                    : const Image(image: AssetImage("assets/mocknavlight.png")),
              ),
              InkWell(
                onTap: () {
                  if (index != 2) {
                    ref.read(routerProvider).go(ProfileView.routename);
                  }
                },
                child: Icon(
                  CarbonIcons.user_filled,
                  size: 34,
                  color: (index == 2)
                      ? const Color(0xff04434E)
                      : const Color(0xff0CC0DF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
