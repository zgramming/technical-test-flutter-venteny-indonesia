import 'package:get_it/get_it.dart';

import 'core/helper/share_preferences.helper.dart';
import 'data/datasources/local/app_config.localdatasource.dart';
import 'domain/repositories/app_config.repository.dart';
import 'domain/usecase/get_app_config.usecase.dart';
import 'presentation/cubit/app_config.cubit.dart';

final sl = GetIt.instance;

void initInjection() {
  // Register Cubit
  sl.registerFactory(() => AppConfigCubit(getAppConfigUseCase: sl()));

  // Register UseCases
  sl.registerLazySingleton(() => GetAppConfigUseCase(repository: sl()));

  // Register Repositories
  sl.registerLazySingleton<AppConfigRepository>(
    () => AppConfigRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Register DataSources
  sl.registerLazySingleton<AppConfigLocalDataSource>(
    () => AppConfigLocalDataSourceImpl(),
  );

  // External
  sl.registerLazySingleton<SharedPreferencesHelper>(
    () => SharedPreferencesHelper(),
  );
}
