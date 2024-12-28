// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../config/enum.dart';
import '../../data/models/app_config.model.dart';

class AppConfigEntity extends Equatable {
  final String loginCredential;
  final bool alreadyShowOnboarding;
  final bool activeNotification;
  final ThemeType themeType;
  const AppConfigEntity({
    this.loginCredential = '',
    this.alreadyShowOnboarding = false,
    this.activeNotification = true,
    this.themeType = ThemeType.light,
  });

  @override
  List<Object> get props => [
        loginCredential,
        alreadyShowOnboarding,
        activeNotification,
        themeType,
      ];

  @override
  bool get stringify => true;

  AppConfigEntity copyWith({
    String? loginCredential,
    bool? alreadyShowOnboarding,
    bool? activeNotification,
    ThemeType? themeType,
  }) {
    return AppConfigEntity(
      loginCredential: loginCredential ?? this.loginCredential,
      alreadyShowOnboarding:
          alreadyShowOnboarding ?? this.alreadyShowOnboarding,
      activeNotification: activeNotification ?? this.activeNotification,
      themeType: themeType ?? this.themeType,
    );
  }

  // Convert AppConfigModel to AppConfigEntity
  factory AppConfigEntity.fromModel(AppConfigModel model) {
    return AppConfigEntity(
      alreadyShowOnboarding: model.alreadyShowOnboarding,
      activeNotification: model.activeNotification,
      themeType: model.themeType,
      loginCredential: model.loginCredential,
    );
  }
}
