import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../../data/models/dto/task_create_or_update.dto.dart';
import '../entities/task.entity.dart';
import '../repositories/task.repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase({
    required this.repository,
  });

  Future<Either<Failure, List<TaskEntity>>> call(TaskCreateOrUpdateDto task) {
    return repository.add(task);
  }
}
