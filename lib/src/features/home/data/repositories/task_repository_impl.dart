import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/features/home/data/datasources/remote/task_remote_datasource.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_model.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_parameter.dart';
import 'package:sabani_tech_test/src/features/home/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasource datasource;

  TaskRepositoryImpl({required this.datasource});
  @override
  Future<Either<String, String>> createTask(
      {required TaskParams params}) async {
    try {
      final result = await datasource.createTask(params: params);
      return result.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  @override
  Future<Either<String, String>> deleteTask({required int id}) async {
    try {
      final result = await datasource.deleteTask(id: id);
      return result.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getTask() async {
    try {
      final result = await datasource.getTask();
      return Right(result);
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  @override
  Future<Either<String, String>> updateTask(
      {required TaskParams params}) async {
    try {
      final result = await datasource.updateTask(params: params);
      return result.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  @override
  Future<Either<String, String>> archiveTask({required int id}) async {
    try {
      final result = await datasource.archiveTask(id: id);
      return result.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  @override
  Future<Either<String, String>> restoreArchiveTask({required int id}) async {
    try {
      final result = await datasource.restoreArchiveTask(id: id);
      return result.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getArchiveTask() async {
    try {
      final result = await datasource.getArchiveTask();
      return Right(result);
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  @override
  Future<Either<String, String>> restoreDeleteTask({required int id}) async {
    try {
      final result = await datasource.restoreDeleteTask(id: id);
      return result.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getDeleteTask() async {
    try {
      final result = await datasource.getDeleteTask();
      return Right(result);
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }
}
