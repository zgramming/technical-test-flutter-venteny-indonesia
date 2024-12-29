import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constant.dart';
import '../../config/enum.dart';

class SharedPreferencesHelper {
  static late final SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<void> setOnboarding(bool value) async {
    await instance.setBool(kSharedPrefOnboardingKey, value);
  }

  static bool getOnboarding() {
    return instance.getBool(kSharedPrefOnboardingKey) ?? false;
  }

  static Future<void> setNotification(bool value) async {
    await instance.setBool(kSharedPrefNotificationKey, value);
  }

  static bool getNotification() {
    return instance.getBool(kSharedPrefNotificationKey) ?? false;
  }

  static Future<void> setTheme(ThemeType theme) async {
    await instance.setString(kSharedPrefThemeKey, theme.name);
  }

  static ThemeType getTheme() {
    final theme = instance.getString(kSharedPrefThemeKey);
    return ThemeType.values
        .firstWhere((e) => e.name == theme, orElse: () => ThemeType.light);
  }

  static Future<void> setLoginCredential(String value) async {
    await instance.setString(kSharedPrefLoginCredentialKey, value);
  }

  static String getLoginCredential() {
    return instance.getString(kSharedPrefLoginCredentialKey) ?? '';
  }

  static Future<void> clear() async {
    await instance.clear();
  }
}
