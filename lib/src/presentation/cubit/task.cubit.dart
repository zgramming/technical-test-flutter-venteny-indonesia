import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/dto/task_create_or_update.dto.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/usecase/add_task.usecase.dart';
import '../../domain/usecase/delete_task.usecase.dart';
import '../../domain/usecase/get_task.usecase.dart';
import '../../domain/usecase/update_tas.usecase.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskSuccessState extends TaskState {
  final List<TaskEntity> tasks;
  final List<TaskEntity> filteredTasks;
  TaskSuccessState({
    this.tasks = const [],
    this.filteredTasks = const [],
  });
}

class TaskErrorState extends TaskState {
  final String message;
  TaskErrorState({required this.message});
}

class TaskCubit extends Cubit<TaskState> {
  final GetTaskUseCase getTaskUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskCubit({
    required this.getTaskUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskInitialState());

  void get() async {
    emit(TaskLoadingState());
    final result = await getTaskUseCase();
    result.fold(
      (l) => emit(TaskErrorState(message: l.message)),
      (r) => emit(
        TaskSuccessState(
          tasks: r,
          filteredTasks: r,
        ),
      ),
    );
  }

  Future<void> add(TaskCreateOrUpdateDto task) async {
    emit(TaskLoadingState());
    final result = await addTaskUseCase(task);
    result.fold(
      (l) => emit(TaskErrorState(message: l.message)),
      (r) => emit(TaskSuccessState(tasks: r, filteredTasks: r)),
    );
  }

  Future<void> update(int id, TaskCreateOrUpdateDto task) async {
    emit(TaskLoadingState());
    final result = await updateTaskUseCase(id, task);
    result.fold(
      (l) => emit(TaskErrorState(message: l.message)),
      (r) => emit(TaskSuccessState(tasks: r, filteredTasks: r)),
    );
  }

  Future<void> delete(int id) async {
    emit(TaskLoadingState());
    final result = await deleteTaskUseCase(id);
    result.fold(
      (l) => emit(TaskErrorState(message: l.message)),
      (r) => emit(TaskSuccessState(tasks: r, filteredTasks: r)),
    );
  }

  void filter({
    String? query,
    TaskState? status,
  }) {
    if (state is TaskSuccessState && query != null) {
      final currentState = state as TaskSuccessState;
      final tasks = [...currentState.tasks];

      final filteredTasks = tasks.where((x) {
        final title = x.title.toLowerCase();
        final queryLower = query.toLowerCase();
        final statusMatch = status == null || x.status == status.toString();

        return title.contains(queryLower) && statusMatch;
      }).toList();

      emit(TaskSuccessState(tasks: tasks, filteredTasks: filteredTasks));
    }
  }
}
