import 'package:equatable/equatable.dart';

import '../task.model.dart';

class TaskOperationResponseModel extends Equatable {
  final bool success;
  final String message;
  final TaskModel? data;
  const TaskOperationResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [success, message, data];

  @override
  bool get stringify => true;

  TaskOperationResponseModel copyWith({
    bool? success,
    String? message,
    TaskModel? data,
  }) {
    return TaskOperationResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
