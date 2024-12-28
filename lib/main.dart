import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/helper/share_preferences.helper.dart';
import 'src/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesHelper.init(); // Initialize SharedPreferences

  initInjection(); // Initialize Injection

// Initialize multip bloc

  runApp(
    const MyApp(),
  );
}
