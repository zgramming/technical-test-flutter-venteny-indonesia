import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/helper/database_sqlite.helper.dart';
import 'src/core/helper/local_notification.helper.dart';
import 'src/core/helper/share_preferences.helper.dart';
import 'src/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationHelper.init(); // Initialize Local Notification
  await SharedPreferencesHelper.init(); // Initialize SharedPreferences
  await DatabaseSQLiteHelper.instance.database; // Initialize Database

  initInjection(); // Initialize Injection

  runApp(const MyApp());
}
