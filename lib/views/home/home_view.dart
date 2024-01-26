import 'package:dhwani/model/dhwani.dart';
import 'package:dhwani/routes/app_route_config.dart';
import 'package:dhwani/views/dhwani_main/dhwani_screen.dart';
import 'package:dhwani/views/mock/mock_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/bottom_navbar.dart';

class HomeView extends ConsumerWidget {
  static const routename = '/home';
  final Widget child;
  const HomeView({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int calculateSelectedIndex() {
      final location = (((child as HeroControllerScope).child as Navigator)
              .pages
              .first
              .key as ValueKey)
          .value;
      switch (location) {
        case '/dhwani':
          return 0;
        case '/mock':
          return 1;
        case '/profile':
          return 2;
        default:
          return 0;
      }
    }

    return Scaffold(
      body: SafeArea(bottom: false, child: child),
      backgroundColor: Colors.blue,
      bottomNavigationBar: BottomNavbar(
        index: calculateSelectedIndex(),
        
      ),
    );
  }
}
