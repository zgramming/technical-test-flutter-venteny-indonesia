import 'package:flutter/material.dart';
import 'package:technical_test_venteny_indonesia/src/config/color.dart';
import 'package:technical_test_venteny_indonesia/src/config/font.dart';

import 'config/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp.router(
      title: 'Task Management App',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: secondaryColor,
          primary: primaryColor,
          surface: Colors.white,
          surfaceTint: Colors.white,
        ),
        useMaterial3: true,
        textTheme: bodyFontTheme(theme.textTheme),
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
    );
  }
}
