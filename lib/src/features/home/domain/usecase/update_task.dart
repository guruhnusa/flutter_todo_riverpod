import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_parameter.dart';
import 'package:sabani_tech_test/src/features/home/domain/repositories/task_repository.dart';

class UpdateTask implements UseCase<String, TaskParams> {
  final TaskRepository repository;

  UpdateTask({required this.repository});

  @override
  Future<Either<String, String>> call(TaskParams params) {
    return repository.updateTask(params: params);
  }
}
