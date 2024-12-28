import '../../../core/helper/share_preferences.helper.dart';
import '../../models/app_config.model.dart';

abstract class AppConfigLocalDataSource {
  AppConfigModel getAppConfig();
}

class AppConfigLocalDataSourceImpl implements AppConfigLocalDataSource {
  @override
  AppConfigModel getAppConfig() {
    final onboarding = SharedPreferencesHelper.getOnboarding();
    final notification = SharedPreferencesHelper.getNotification();
    final theme = SharedPreferencesHelper.getTheme();
    final loginCredential = SharedPreferencesHelper.getLoginCredential();

    return AppConfigModel(
      alreadyShowOnboarding: onboarding,
      activeNotification: notification,
      themeType: theme,
      loginCredential: loginCredential,
    );
  }
}
