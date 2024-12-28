// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../../data/datasources/local/app_config.localdatasource.dart';
import '../entities/app_config.entity.dart';

abstract class AppConfigRepository {
  Either<Failure, AppConfigEntity> getAppConfig();
}

class AppConfigRepositoryImpl implements AppConfigRepository {
  final AppConfigLocalDataSource localDataSource;
  AppConfigRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Either<Failure, AppConfigEntity> getAppConfig() {
    try {
      final result = localDataSource.getAppConfig();
      return Right(AppConfigEntity.fromModel(result));
    } on Exception {
      return const Left(CommonFailure("Failed to get app config"));
    }
  }
}
