import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/update_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';

part 'update_task_provider.g.dart';

@riverpod
UpdateTask updateTask(UpdateTaskRef ref) {
  return UpdateTask(
    repository: ref.read(taskRepositoryProvider),
  );
}
