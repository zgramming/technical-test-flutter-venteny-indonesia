import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../entities/task.entity.dart';
import '../repositories/task.repository.dart';

class GetTaskUseCase {
  final TaskRepository repository;

  GetTaskUseCase({
    required this.repository,
  });

  Future<Either<Failure, List<TaskEntity>>> call() async {
    return repository.get();
  }
}
