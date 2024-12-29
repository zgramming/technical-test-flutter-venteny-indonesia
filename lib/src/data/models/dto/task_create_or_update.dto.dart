import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskCreateOrUpdateDto extends Equatable {
  final String title;
  final String description;
  final DateTime dueDate;
  final String status;

  const TaskCreateOrUpdateDto({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      title,
      description,
      dueDate,
      status,
    ];
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  factory TaskCreateOrUpdateDto.fromJson(String source) =>
      TaskCreateOrUpdateDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  factory TaskCreateOrUpdateDto.fromMap(Map<String, dynamic> map) {
    return TaskCreateOrUpdateDto(
      title: map['title'] as String,
      description: map['description'] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      status: map['status'] as String,
    );
  }
}
