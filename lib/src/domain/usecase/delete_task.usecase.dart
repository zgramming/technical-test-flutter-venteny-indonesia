import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../entities/response/task_operation_response.entity.dart';
import '../repositories/task.repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase({
    required this.repository,
  });

  Future<Either<Failure, TaskOperationResponseEntity>> call(int id) {
    return repository.delete(id);
  }
}
