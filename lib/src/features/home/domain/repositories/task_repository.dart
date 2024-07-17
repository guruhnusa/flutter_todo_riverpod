import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_model.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_parameter.dart';

abstract class TaskRepository {
  Future<Either<String, List<TaskModel>>> getTask();
  Future<Either<String, String>> createTask({
    required TaskParams params,
  });
  Future<Either<String, String>> deleteTask({required int id});
  Future<Either<String, String>> restoreDeleteTask({
    required int id,
  });
  Future<Either<String, String>> updateTask({
    required TaskParams params,
  });
  Future<Either<String, String>> archiveTask({
    required int id,
  });
  Future<Either<String, String>> restoreArchiveTask({
    required int id,
  });
  Future<Either<String, List<TaskModel>>> getArchiveTask();
  Future<Either<String, List<TaskModel>>> getDeleteTask();
}
