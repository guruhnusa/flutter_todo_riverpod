import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/get_delete_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';

part 'get_delete_task_provider.g.dart';

@riverpod
GetDeleteTask getDeleteTask(GetDeleteTaskRef ref) {
  return GetDeleteTask(
    repository: ref.read(taskRepositoryProvider),
  );
}
