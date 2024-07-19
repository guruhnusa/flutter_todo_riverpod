import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/archive_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_repository_provider.dart';
part 'archive_task_provider.g.dart';

@riverpod
ArchiveTask archiveTask(ArchiveTaskRef ref) {
  return ArchiveTask(repository: ref.read(taskRepositoryProvider));
}