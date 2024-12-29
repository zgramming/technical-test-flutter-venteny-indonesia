import 'package:equatable/equatable.dart';

import '../../data/models/task.model.dart';

class TaskEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String status;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      dueDate,
      status,
    ];
  }

  @override
  bool get stringify => true;

  factory TaskEntity.fromModel(TaskModel model) {
    return TaskEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      dueDate: model.dueDate,
      status: model.status,
    );
  }
}
