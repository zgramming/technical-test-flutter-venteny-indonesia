import 'package:equatable/equatable.dart';

import '../../../data/models/response/task_operation_response.model.dart';
import '../task.entity.dart';

class TaskOperationResponseEntity extends Equatable {
  final bool success;
  final String message;
  final TaskEntity? data;
  const TaskOperationResponseEntity({
    required this.success,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [success, message, data];

  @override
  bool get stringify => true;

  factory TaskOperationResponseEntity.fromModel(TaskOperationResponseModel model) {
    return TaskOperationResponseEntity(
      success: model.success,
      message: model.message,
      data: model.data != null ? TaskEntity.fromModel(model.data!) : null,
    );
  }
}
