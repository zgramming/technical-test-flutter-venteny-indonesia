import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/enum.dart';

class TaskFilterQueryState extends Equatable {
  final String query;
  final TaskStatus? status;

  const TaskFilterQueryState({
    this.query = '',
    this.status,
  });

  TaskFilterQueryState copyWith({
    String? query,
    TaskStatus? status,
  }) {
    return TaskFilterQueryState(
      query: query ?? this.query,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [query, status];
}

class TaskFilterQueryCubit extends Cubit<TaskFilterQueryState> {
  TaskFilterQueryCubit() : super(const TaskFilterQueryState());

  void setQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void setStatus(TaskStatus? status) {
    emit(state.copyWith(status: status));
  }

  void clear() {
    emit(const TaskFilterQueryState());
  }
}
