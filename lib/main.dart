import 'package:appwrite/models.dart';
import 'package:dhwani/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/app_route_config.dart';

void main() {
  runApp(const ProviderScope(child: DhwaniApp()));
}

final authCheckProvider = FutureProvider<User?>((ref) {
  return ref.watch(authServiceProvider).getUser();
});

class DhwaniApp extends ConsumerWidget {
  const DhwaniApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);    
    return MaterialApp.router(
      title: 'Dhwani',
      theme: ThemeData(fontFamily: GoogleFonts.arimo().fontFamily),
      debugShowCheckedModeBanner: false,
      routerConfig: route,
    );
  }
}
