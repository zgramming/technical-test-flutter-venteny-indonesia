import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_config.entity.dart';
import '../../domain/usecase/get_app_config.usecase.dart';

class AppConfigState extends Equatable {
  final AppConfigEntity? appConfig;
  const AppConfigState({
    this.appConfig = const AppConfigEntity(),
  });

  @override
  List<Object?> get props => [appConfig];

  @override
  bool get stringify => true;

  AppConfigState copyWith({
    AppConfigEntity? appConfig,
  }) {
    return AppConfigState(
      appConfig: appConfig ?? this.appConfig,
    );
  }
}

class AppConfigCubit extends Cubit<AppConfigState> {
  final GetAppConfigUseCase getAppConfigUseCase;
  AppConfigCubit({
    required this.getAppConfigUseCase,
  }) : super(const AppConfigState()) {
    loadAppConfig();
  }

  void loadAppConfig() async {
    final result = getAppConfigUseCase();

    // Adding delay for splash screen
    await Future.delayed(const Duration(seconds: 3));

    result.fold(
      (failure) {
        emit(state.copyWith(appConfig: const AppConfigEntity()));
      },
      (data) {
        emit(state.copyWith(appConfig: data));
      },
    );
  }
}
