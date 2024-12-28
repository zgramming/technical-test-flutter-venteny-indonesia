// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../config/enum.dart';

class AppConfigModel extends Equatable {
  final String loginCredential;
  final bool alreadyShowOnboarding;
  final bool activeNotification;
  final ThemeType themeType;

  const AppConfigModel({
    this.loginCredential = '',
    this.alreadyShowOnboarding = false,
    this.activeNotification = true,
    this.themeType = ThemeType.light,
  });

  @override
  List<Object?> get props => [
        loginCredential,
        alreadyShowOnboarding,
        activeNotification,
        themeType,
      ];

  @override
  bool get stringify => true;

  AppConfigModel copyWith({
    String? loginCredential,
    bool? alreadyShowOnboarding,
    bool? activeNotification,
    ThemeType? themeType,
  }) {
    return AppConfigModel(
      loginCredential: loginCredential ?? this.loginCredential,
      alreadyShowOnboarding:
          alreadyShowOnboarding ?? this.alreadyShowOnboarding,
      activeNotification: activeNotification ?? this.activeNotification,
      themeType: themeType ?? this.themeType,
    );
  }
}
