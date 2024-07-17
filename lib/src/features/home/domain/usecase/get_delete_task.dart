import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_model.dart';
import 'package:sabani_tech_test/src/features/home/domain/repositories/task_repository.dart';

class GetDeleteTask implements UseCase<List<TaskModel>, void> {
  final TaskRepository repository;

  GetDeleteTask({required this.repository});
  @override
  Future<Either<String, List<TaskModel>>> call(void params) {
    return repository.getDeleteTask();
  }
}
