import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../config/color.dart';
import '../../config/font.dart';
import '../../config/routes.dart';

import '../../config/enum.dart';
import '../../core/helper/share_preferences.helper.dart';
import '../cubit/app_config.cubit.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final name = "Zainal Arifin";
  final email = "zainal.arifin@gmail.com";

  Future<void> onChangeTheme(ThemeType? theme) async {
    final result = theme ?? ThemeType.light;

    context.read<AppConfigCubit>().toggleTheme(result);
  }

  Future<void> onChangeNotification(bool value) async {
    context.read<AppConfigCubit>().toggleNotification(value);
  }

  Future<void> onLogout() async {
    await SharedPreferencesHelper.clear();
    if (!mounted) return;

    context.pushReplacementNamed(RoutersName.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigCubit, AppConfigState>(
      builder: (context, state) {
        final isLoaded = state is AppConfigStateLoaded;
        final selectedTheme =
            isLoaded ? (state).appConfig.themeType : ThemeType.light;
        final selectedNotification =
            isLoaded ? (state).appConfig.activeNotification : true;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...[
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/54469572?v=4',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                ...[
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            leading: Icon(
                              selectedTheme == ThemeType.light
                                  ? FontAwesomeIcons.solidSun
                                  : FontAwesomeIcons.solidMoon,
                              size: 20,
                              color: selectedTheme == ThemeType.light
                                  ? Colors.orange
                                  : Colors.blueGrey,
                            ),
                            title: Text(
                              'Theme',
                              style: bodyFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Change the app's theme",
                              style: bodyFont.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: DropdownButton<ThemeType>(
                              value: selectedTheme,
                              onChanged: (value) => onChangeTheme(value),
                              items: ThemeType.values
                                  .map(
                                    (theme) => DropdownMenuItem(
                                      value: theme,
                                      child: Text(theme
                                          .toString()
                                          .split('.')
                                          .last
                                          .toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              FontAwesomeIcons.bell,
                              size: 20,
                              color: primaryColor,
                            ),
                            title: Text(
                              'Notification',
                              style: bodyFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Enable or disable notification",
                              style: bodyFont.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: Switch(
                              value: selectedNotification,
                              onChanged: onChangeNotification,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              FontAwesomeIcons.rightFromBracket,
                              size: 20,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Logout',
                              style: bodyFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Logout from the app",
                              style: bodyFont.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            onTap: onLogout,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
