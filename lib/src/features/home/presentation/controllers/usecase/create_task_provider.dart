import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/create_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';
part 'create_task_provider.g.dart';

@riverpod
CreateTask createTask(CreateTaskRef ref) {
  return CreateTask(repository: ref.read(taskRepositoryProvider));
}