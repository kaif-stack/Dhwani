import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes extends StatelessWidget {
  const Routes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed("Login");
                },
                child: const Text("Login Page")),
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed("Onboarding");
                },
                child: const Text("Onboarding Page")),
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed("Dhwani Screen");
                },
                child: const Text("Dhwani Screen")),
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed("Mock Test");
                },
                child: const Text("Mock Test"))
          ],
        ),
      ),
    );
  }
}
