import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/get_archive_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';

part 'get_archive_task_provider.g.dart';

@riverpod
GetArchiveTask getArchiveTask(GetArchiveTaskRef ref) {
  return GetArchiveTask(
    repository: ref.read(taskRepositoryProvider),
  );
}
