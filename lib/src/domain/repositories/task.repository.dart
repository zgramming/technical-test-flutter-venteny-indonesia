import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../../data/datasources/local/task.localdatasource.dart';
import '../../data/models/dto/task_create_or_update.dto.dart';
import '../entities/response/task_operation_response.entity.dart';
import '../entities/task.entity.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> get();
  Future<Either<Failure, TaskEntity>> getById(int id);
  Future<Either<Failure, TaskOperationResponseEntity>> add(
    TaskCreateOrUpdateDto task,
  );
  Future<Either<Failure, TaskOperationResponseEntity>> update(
    int id,
    TaskCreateOrUpdateDto task,
  );
  Future<Either<Failure, TaskOperationResponseEntity>> delete(int id);
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TaskEntity>>> get() async {
    try {
      final result = await localDataSource.get();
      final entities = result.map((x) => TaskEntity.fromModel(x)).toList();
      return Right(entities);
    } catch (e) {
      log("Error: $e");
      return const Left(CommonFailure('Failed to get tasks'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getById(int id) async {
    try {
      final result = await localDataSource.getById(id);
      final entity = TaskEntity.fromModel(result);
      return Right(entity);
    } catch (e) {
      log("Error: $e");
      return const Left(CommonFailure('Failed to get task by id'));
    }
  }

  @override
  Future<Either<Failure, TaskOperationResponseEntity>> add(
    TaskCreateOrUpdateDto task,
  ) async {
    try {
      final result = await localDataSource.add(task);
      final entity = TaskOperationResponseEntity.fromModel(result);
      return Right(entity);
    } catch (e) {
      log("Error Add Task: $e");
      return const Left(CommonFailure('Failed to add task'));
    }
  }

  @override
  Future<Either<Failure, TaskOperationResponseEntity>> update(
    int id,
    TaskCreateOrUpdateDto task,
  ) async {
    try {
      final result = await localDataSource.update(id, task);
      final entity = TaskOperationResponseEntity.fromModel(result);
      return Right(entity);
    } catch (e) {
      log("Error Update Task: $e");
      return const Left(CommonFailure('Failed to update task'));
    }
  }

  @override
  Future<Either<Failure, TaskOperationResponseEntity>> delete(int id) async {
    try {
      final result = await localDataSource.delete(id);
      final entity = TaskOperationResponseEntity.fromModel(result);
      return Right(entity);
    } catch (e) {
      log("Error Delete Task: $e");
      return const Left(CommonFailure('Failed to delete task'));
    }
  }
}
