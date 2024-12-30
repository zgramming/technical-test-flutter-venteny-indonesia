import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../../data/models/dto/task_create_or_update.dto.dart';
import '../entities/response/task_operation_response.entity.dart';
import '../repositories/task.repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase({
    required this.repository,
  });

  Future<Either<Failure, TaskOperationResponseEntity>> call(
    int id,
    TaskCreateOrUpdateDto task,
  ) {
    return repository.update(id, task);
  }
}
