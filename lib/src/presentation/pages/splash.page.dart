import 'package:flutter/material.dart';

import '../../config/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _navigateToNextPage());
  }

  Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    router.goNamed(RoutersName.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // Loading indicator
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
