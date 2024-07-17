import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/home/domain/repositories/task_repository.dart';

class RestoreDeleteTask implements UseCase<String, int> {
  final TaskRepository repository;

  RestoreDeleteTask({required this.repository});

  @override
  Future<Either<String, String>> call(int params) {
    return repository.restoreDeleteTask(id: params);
  }
}
