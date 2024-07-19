import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/restore_archive_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';

part 'restore_task_provider.g.dart';

@riverpod
RestoreArchiveTask restoreArchiveTask(RestoreArchiveTaskRef ref) {
  return RestoreArchiveTask(
    repository: ref.read(taskRepositoryProvider),
  );
}
