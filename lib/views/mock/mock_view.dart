import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/bottom_navbar.dart';

class MockView extends ConsumerWidget {
  static const routename = '/mock';
  const MockView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(bottom: false, child: Material()),
      backgroundColor: Colors.orange,
    );
  }
}
