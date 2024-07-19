import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/restore_delete_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';

part 'restore_delete_provider.g.dart';

@riverpod
RestoreDeleteTask restoreDeleteTask(RestoreDeleteTaskRef ref) {
  return RestoreDeleteTask(
    repository: ref.read(taskRepositoryProvider),
  );
}
