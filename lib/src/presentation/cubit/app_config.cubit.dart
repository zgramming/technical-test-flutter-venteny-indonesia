import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/enum.dart';
import '../../core/helper/share_preferences.helper.dart';
import '../../domain/entities/app_config.entity.dart';
import '../../domain/usecase/get_app_config.usecase.dart';

abstract class AppConfigState {}

class AppConfigStateLoading extends AppConfigState {}

class AppConfigStateLoaded extends AppConfigState {
  final AppConfigEntity appConfig;
  AppConfigStateLoaded(this.appConfig);
}

class AppConfigStateError extends AppConfigState {
  final String message;
  AppConfigStateError(this.message);
}

class AppConfigCubit extends Cubit<AppConfigState> {
  final GetAppConfigUseCase getAppConfigUseCase;
  AppConfigCubit({
    required this.getAppConfigUseCase,
  }) : super(AppConfigStateLoading()) {
    loadAppConfig();
  }

  void loadAppConfig() async {
    final result = getAppConfigUseCase();

    // Adding delay for splash screen
    await Future.delayed(const Duration(seconds: 3));

    result.fold(
      (failure) {
        emit(AppConfigStateError(failure.message));
      },
      (data) {
        emit(AppConfigStateLoaded(data));
      },
    );
  }

  void toggleTheme(ThemeType? theme) async {
    final currentState = state;
    if (currentState is AppConfigStateLoaded) {
      final newTheme = currentState.appConfig.themeType == ThemeType.light
          ? ThemeType.dark
          : ThemeType.light;
      final newAppConfig = currentState.appConfig.copyWith(themeType: newTheme);
      await SharedPreferencesHelper.setTheme(theme ?? ThemeType.light);

      emit(AppConfigStateLoaded(newAppConfig));
    }
  }

  void toggleNotification(bool value) async {
    final currentState = state;
    if (currentState is AppConfigStateLoaded) {
      final newNotification = !currentState.appConfig.activeNotification;
      final newAppConfig =
          currentState.appConfig.copyWith(activeNotification: newNotification);

      await SharedPreferencesHelper.setNotification(value);
      emit(AppConfigStateLoaded(newAppConfig));
    }
  }
}
