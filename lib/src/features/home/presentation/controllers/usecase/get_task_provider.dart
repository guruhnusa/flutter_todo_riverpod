import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/get_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';

part 'get_task_provider.g.dart';

@riverpod
GetTask getTask(GetTaskRef ref) {
  return GetTask(
    repository: ref.read(taskRepositoryProvider),
  );
}
