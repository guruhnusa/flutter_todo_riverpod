import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/delete_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';

part 'delete_task_provider.g.dart';

@riverpod
DeleteTask deleteTask(DeleteTaskRef ref) {
  return DeleteTask(repository: ref.read(taskRepositoryProvider));
}
