import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task.entity.dart';
import '../../domain/usecase/get_task_detail.usecase.dart';

abstract class TaskDetailState {}

class TaskDetailInitialState extends TaskDetailState {}

class TaskDetailLoadingState extends TaskDetailState {}

class TaskDetailSuccessState extends TaskDetailState {
  final TaskEntity task;
  TaskDetailSuccessState({required this.task});
}

class TaskDetailErrorState extends TaskDetailState {
  final String message;
  TaskDetailErrorState({required this.message});
}

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final GetTaskByIdUseCase getTaskByIdUseCase;

  TaskDetailCubit({
    required this.getTaskByIdUseCase,
  }) : super(TaskDetailInitialState());

  void get(int id) async {
    emit(TaskDetailLoadingState());
    final result = await getTaskByIdUseCase(id);
    result.fold(
      (l) => emit(TaskDetailErrorState(message: l.message)),
      (r) => emit(TaskDetailSuccessState(task: r)),
    );
  }
}
