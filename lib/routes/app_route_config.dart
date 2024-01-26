import 'package:dhwani/main.dart';
import 'package:dhwani/views/auth/signup_view.dart';
import 'package:dhwani/views/home/home_view.dart';
import 'package:dhwani/views/mock/mock_view.dart';
import 'package:dhwani/views/onboarding/onboarding_view.dart';
import 'package:dhwani/views/profile/profile_view.dart';
import 'package:dhwani/views/routes_view/routeview.dart';
import 'package:dhwani/views/splash_screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../views/auth/login_view.dart';
import '../views/dhwani_main/dhwani_screen.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

GoRouter? _previousRouter;

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authCheckProvider);
  return GoRouter(
      navigatorKey: _navigatorKey,
      redirect: (context, state) {
        return auth.when(
            data: (user) {
              if (user == null) {
                if (state.matchedLocation == '/' ||
                    state.matchedLocation == DhwaniScreen.routename) {
                  return LoginView.routename;
                }
                return null;
              } else {
                if (state.matchedLocation case '/') {
                  return DhwaniScreen.routename;
                }
                return null;
              }
            },
            error: (e, _) => '/',
            loading: () => '/');
      },
      routes: [
        GoRoute(
          name: 'Splash Screen',
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => HomeView(
                  child: child,
                ),
            routes: [
              GoRoute(
                name: 'Dhwani Screen',
                path: DhwaniScreen.routename,
                builder: (context, state) =>
                    const DhwaniScreen(key: ValueKey(#dhwani)),
              ),
              GoRoute(
                name: 'Mock Test',
                path: MockView.routename,
                builder: (context, state) =>
                    const MockView(key: ValueKey(#mocktest)),
              ),
              GoRoute(
                name: 'Profile',
                path: ProfileView.routename,
                builder: (context, state) {
                  return const ProfileView(key: ValueKey(#profile));
                },
              ),
            ]),
        GoRoute(
          name: 'Login',
          path: LoginView.routename,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          name: 'Signup',
          path: SignupView.routename,
          builder: (context, state) => const SignupView(),
        ),
        GoRoute(
          name: 'Onboarding',
          path: OnboardingScreen.routename,
          builder: (context, state) => const OnboardingScreen(),
        ),
      ]);
});
