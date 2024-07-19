import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/home/domain/repositories/task_repository.dart';

class RestoreArchiveTask implements UseCase<String, int> {
  final TaskRepository repository;

  RestoreArchiveTask({required this.repository});

  @override
  Future<Either<String, String>> call(int params) {
    return repository.restoreArchiveTask(id: params);
  }
}
