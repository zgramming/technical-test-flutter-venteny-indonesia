import 'package:get_it/get_it.dart';

import 'core/helper/database_sqlite.helper.dart';
import 'core/helper/http_client.helper.dart';
import 'core/helper/share_preferences.helper.dart';
import 'data/datasources/local/app_config.localdatasource.dart';
import 'data/datasources/local/task.localdatasource.dart';
import 'data/datasources/remote/auth.remotedatasource.dart';
import 'domain/repositories/app_config.repository.dart';
import 'domain/repositories/auth.repository.dart';
import 'domain/repositories/task.repository.dart';
import 'domain/usecase/add_task.usecase.dart';
import 'domain/usecase/delete_task.usecase.dart';
import 'domain/usecase/get_app_config.usecase.dart';
import 'domain/usecase/get_task.usecase.dart';
import 'domain/usecase/get_task_detail.usecase.dart';
import 'domain/usecase/login.usecase.dart';
import 'domain/usecase/logout.usecase.dart';
import 'domain/usecase/update_tas.usecase.dart';
import 'presentation/cubit/app_config.cubit.dart';
import 'presentation/cubit/auth.cubit.dart';
import 'presentation/cubit/task.cubit.dart';
import 'presentation/cubit/task_detail.cubit.dart';
import 'presentation/cubit/task_filter_query.cubit.dart';

final sl = GetIt.instance;

void initInjection() {
  // Register Cubit / Bloc
  sl.registerFactory(() => AppConfigCubit(getAppConfigUseCase: sl()));
  sl.registerFactory(() => AuthCubit(loginUseCase: sl(), logoutUseCase: sl()));
  sl.registerFactory(
    () => TaskCubit(
      getTaskUseCase: sl(),
      addTaskUseCase: sl(),
      updateTaskUseCase: sl(),
      deleteTaskUseCase: sl(),
    ),
  );
  sl.registerFactory(() => TaskDetailCubit(getTaskByIdUseCase: sl()));
  sl.registerFactory(() => TaskFilterQueryCubit());

  // Register UseCases
  sl.registerLazySingleton(() => GetAppConfigUseCase(repository: sl()));

  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));

  sl.registerLazySingleton(() => GetTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTaskByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(repository: sl()));

  // Register Repositories
  sl.registerLazySingleton<AppConfigRepository>(
    () => AppConfigRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localDataSource: sl()),
  );

  // Register DataSources
  sl.registerLazySingleton<AppConfigLocalDataSource>(
    () => AppConfigLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(databaseSQLiteHelper: sl()),
  );

  // External
  sl.registerLazySingleton<SharedPreferencesHelper>(
    () => SharedPreferencesHelper(),
  );
  sl.registerLazySingleton<HttpClientHelper>(
    () => HttpClientHelper(),
  );
  sl.registerLazySingleton<DatabaseSQLiteHelper>(
    () => DatabaseSQLiteHelper.instance,
  );
}
