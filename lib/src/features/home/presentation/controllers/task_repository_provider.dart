import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/core/network/dio_provider.dart';
import 'package:sabani_tech_test/src/features/home/data/datasources/remote/task_remote_datasource.dart';
import 'package:sabani_tech_test/src/features/home/data/repositories/task_repository_impl.dart';
import 'package:sabani_tech_test/src/features/home/domain/repositories/task_repository.dart';

part 'task_repository_provider.g.dart';

@riverpod
TaskRepository taskRepository(TaskRepositoryRef ref) {
  return TaskRepositoryImpl(
    datasource: TaskRemoteDatasourceImpl(
      httpClient: ref.read(dioProvider),
    ),
  );
}
