// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

class TaskParams {
  int? id;
  final String title;
  final String description;
  final String dueDate;
  final String priority;
  String? status;
  File? file;

  TaskParams(
      {this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.priority,
      this.status,
      this.file});

  Map<String, dynamic> toPost() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'due_date': dueDate,
      'task_priority': priority,
      'file': file,
    };
  }

  Map<String, dynamic> toUpdate() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'due_date': dueDate,
      'task_priority': priority,
      'status_task': status,
    };
  }

  String toJsonCreate() => json.encode(toPost());
  String toJsonUpdate() => json.encode(toUpdate());

  TaskParams copyWith({
    int? id,
    String? title,
    String? description,
    String? dueDate,
    String? priority,
    File? file,
  }) {
    return TaskParams(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      file: file ?? this.file,
    );
  }
}
