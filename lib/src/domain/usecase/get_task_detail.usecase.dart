import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../entities/task.entity.dart';
import '../repositories/task.repository.dart';

class GetTaskByIdUseCase {
  final TaskRepository repository;

  GetTaskByIdUseCase({
    required this.repository,
  });

  Future<Either<Failure, TaskEntity>> call(int id) async {
    return repository.getById(id);
  }
}
