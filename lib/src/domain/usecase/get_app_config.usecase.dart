import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../entities/app_config.entity.dart';
import '../repositories/app_config.repository.dart';

class GetAppConfigUseCase {
  final AppConfigRepository repository;
  GetAppConfigUseCase({
    required this.repository,
  });

  Either<Failure, AppConfigEntity> call() {
    return repository.getAppConfig();
  }
}
