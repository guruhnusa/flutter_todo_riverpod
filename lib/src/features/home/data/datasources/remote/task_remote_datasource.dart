import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sabani_tech_test/src/core/utils/errors/dio_error.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_model.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_parameter.dart';

abstract class TaskRemoteDatasource {
  Future<List<TaskModel>> getTask();
  Future<Either<String, String>> createTask({required TaskParams params});
  Future<Either<String, String>> deleteTask({required int id});
  Future<Either<String, String>> restoreDeleteTask({required int id});

  Future<Either<String, String>> updateTask({required TaskParams params});
  Future<Either<String, String>> archiveTask({required int id});
  Future<Either<String, String>> restoreArchiveTask({required int id});
  Future<List<TaskModel>> getArchiveTask();
  Future<List<TaskModel>> getDeleteTask();
}

class TaskRemoteDatasourceImpl implements TaskRemoteDatasource {
  final Dio httpClient;

  TaskRemoteDatasourceImpl({required this.httpClient});
  @override
  Future<Either<String, String>> createTask(
      {required TaskParams params}) async {
    try {
      final formData = FormData.fromMap({
        'title': params.title,
        'description': params.description,
        'due_date': params.dueDate,
        'task_priority': params.priority,
        'file': await MultipartFile.fromFile(params.file!.path,
            filename: params.file!.path.split('/').last),
      });
      final response = await httpClient.post(
        '/task_management',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        return Right(response.data["message"]);
      } else {
        return Left(response.data["message"]);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    }
  }

  @override
  Future<Either<String, String>> deleteTask({required int id}) async {
    try {
      final response = await httpClient.delete('/task_management/$id');
      if (response.statusCode == 200) {
        return Right(response.data["message"]);
      } else {
        return Left(response.data["message"]);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    }
  }

  @override
  Future<List<TaskModel>> getTask() async {
    try {
      final response = await httpClient.get('/task_management');
      if (response.statusCode == 200) {
        final data = (response.data["data"] as List)
            .map((e) => TaskModel.fromJson(e))
            .toList();

        return data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }

  @override
  Future<Either<String, String>> updateTask(
      {required TaskParams params}) async {
    try {
      final response = await httpClient.put(
        '/task_management/${params.id}',
        data: params.toJsonUpdate(),
      );

      if (response.statusCode == 200) {
        return Right(response.data["message"]);
      } else {
        return Left(response.data["message"]);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    }
  }

  @override
  Future<Either<String, String>> archiveTask({required int id}) async {
    try {
      final response = await httpClient.post(
        '/archives/task/$id/archive',
      );

      if (response.statusCode == 200) {
        return Right(response.data["message"]);
      } else {
        return Left(response.data["message"]);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    }
  }

  @override
  Future<Either<String, String>> restoreArchiveTask({required int id}) async {
    try {
      final response = await httpClient.post(
        '/archives/task/$id/restore',
      );

      if (response.statusCode == 200) {
        return Right(response.data["message"]);
      } else {
        return Left(response.data["message"]);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    }
  }

  @override
  Future<List<TaskModel>> getArchiveTask() async {
    try {
      final response = await httpClient.get('/archives');
      if (response.statusCode == 200) {
        final data = (response.data["data"] as List)
            .map((e) => TaskModel.fromJson(e))
            .toList();
        return data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }

  @override
  Future<Either<String, String>> restoreDeleteTask({required int id}) async {
    try {
      final response = await httpClient.post(
        '/trash/restore/$id/task',
      );

      if (response.statusCode == 200) {
        return Right(response.data["message"]);
      } else {
        return Left(response.data["message"]);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(error);
    }
  }

  @override
  Future<List<TaskModel>> getDeleteTask() async {
    try {
      final response = await httpClient.get('/trash/task');
      if (response.statusCode == 200) {
        final data = (response.data["data"] as List)
            .map((e) => TaskModel.fromJson(e))
            .toList();
        return data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }
}
