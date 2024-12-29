import 'package:flutter_bloc/flutter_bloc.dart';

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
}
