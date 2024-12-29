import 'package:get_it/get_it.dart';

import 'core/helper/http_client.helper.dart';
import 'core/helper/share_preferences.helper.dart';
import 'data/datasources/local/app_config.localdatasource.dart';
import 'data/datasources/remote/auth.remotedatasource.dart';
import 'domain/repositories/app_config.repository.dart';
import 'domain/repositories/auth.repository.dart';
import 'domain/usecase/get_app_config.usecase.dart';
import 'domain/usecase/login.usecase.dart';
import 'domain/usecase/logout.usecase.dart';
import 'presentation/cubit/app_config.cubit.dart';
import 'presentation/cubit/auth.cubit.dart';

final sl = GetIt.instance;

void initInjection() {
  // Register Cubit
  sl.registerFactory(() => AppConfigCubit(getAppConfigUseCase: sl()));

  sl.registerFactory(() => AuthCubit(loginUseCase: sl(), logoutUseCase: sl()));

  // Register UseCases
  sl.registerLazySingleton(() => GetAppConfigUseCase(repository: sl()));

  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));

  // Register Repositories
  sl.registerLazySingleton<AppConfigRepository>(
    () => AppConfigRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Register DataSources
  sl.registerLazySingleton<AppConfigLocalDataSource>(
    () => AppConfigLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton<SharedPreferencesHelper>(
    () => SharedPreferencesHelper(),
  );

  sl.registerLazySingleton<HttpClientHelper>(
    () => HttpClientHelper(),
  );
}
