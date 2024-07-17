import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/core/routers/routers.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_model.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_parameter.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/archive_task.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/create_task.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/delete_task.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/get_archive_task.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/get_delete_task.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/get_task.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/restore_archive_task.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/restore_delete_task.dart';
import 'package:sabani_tech_test/src/features/home/domain/usecase/update_task.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/archive_task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/create_task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/delete_task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/get_archive_task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/get_delete_task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/get_task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/restore_delete_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/restore_task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/usecase/update_task_provider.dart';

part 'task_provider.g.dart';

@riverpod
class Task extends _$Task {
  static List<TaskModel> taskList = [];
  static List<TaskModel> searchTaskList = [];
  @override
  FutureOr<List<TaskModel>> build() {
    return [];
  }

  Future getTasks() async {
    state = const AsyncLoading();
    GetTask getTask = ref.read(getTaskProvider);
    final result = await getTask(null);
    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (success) {
        taskList = success;
        searchTaskList = success;
        state = AsyncData(success);
      },
    );
  }

  Future filterStatusTask({required String status}) async {
    state = const AsyncLoading();
    List<TaskModel> filteredTask = status == 'all'
        ? taskList
        : taskList.where((element) => element.statusTask == status).toList();
    searchTaskList = filteredTask;
    state = AsyncData(filteredTask);
  }

  Future searchTask({required String query}) async {
    List<TaskModel> filteredTask = searchTaskList
        .where((element) =>
            element.title!.toLowerCase().contains(query.toLowerCase()) ||
            element.description!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    state = AsyncData(filteredTask);
  }

  Future createTask({
    required TaskParams params,
    void Function({required String message})? onSuccess,
    void Function({required String message})? onError,
  }) async {
    state = const AsyncLoading();
    CreateTask createTask = ref.read(createTaskProvider);
    final result = await createTask(params);
    result.fold(
      (failure) {
        onError!(message: failure);
        state = AsyncError(failure, StackTrace.current);
      },
      (success) async {
        onSuccess!(message: success);
        ref.read(routerProvider).pop();
        getTasks();
        await future;
      },
    );
  }

  Future updateTask({
    required TaskParams params,
    Function({required String message})? onSuccess,
    Function({required String message})? onError,
  }) async {
    state = const AsyncLoading();
    UpdateTask updateTask = ref.read(updateTaskProvider);
    final result = await updateTask(params);
    result.fold(
      (failure) {
        onError!(message: failure);
        state = AsyncError(failure, StackTrace.current);
      },
      (success) async {
        onSuccess!(message: success);
      },
    );
  }

  Future getDeleteTask() async {
    state = const AsyncLoading();
    GetDeleteTask getDeleteTask = ref.read(getDeleteTaskProvider);
    final result = await getDeleteTask(null);
    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (success) {
        state = AsyncData(success);
      },
    );
  }

  Future deleteTask({
    required int id,
    Function({required String message})? onSuccess,
    Function({required String message})? onError,
  }) async {
    state = const AsyncLoading();
    DeleteTask deleteTask = ref.read(deleteTaskProvider);
    final result = await deleteTask(id);
    result.fold(
      (failure) {
        onError!(message: failure);
        state = AsyncError(failure, StackTrace.current);
      },
      (success) async {
        onSuccess!(message: success);
        ref.read(routerProvider).pop();
      },
    );
  }

  Future restoreDeleteTask({
    required int id,
    Function({required String message})? onSuccess,
    Function({required String message})? onError,
  }) async {
    RestoreDeleteTask restoreDeleteTask = ref.read(restoreDeleteTaskProvider);
    final result = await restoreDeleteTask(id);
    result.fold(
      (failure) {
        onError!(message: failure);
        state = AsyncError(failure, StackTrace.current);
      },
      (success) {
        onSuccess!(message: success);
        getDeleteTask();
      },
    );
  }

  Future<void> getArchiveTask() async {
    state = const AsyncLoading();
    GetArchiveTask getArchiveTask = ref.read(getArchiveTaskProvider);
    final result = await getArchiveTask(null);
    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (success) {
        state = AsyncData(success);
      },
    );
  }

  Future<void> archiveTask({
    required int id,
    Function({required String message})? onSuccess,
    Function({required String message})? onError,
  }) async {
    ArchiveTask archiveTask = ref.read(archiveTaskProvider);
    final result = await archiveTask(id);
    result.fold(
      (failure) {
        onError!(message: failure);
        state = AsyncError(failure, StackTrace.current);
      },
      (success) {
        onSuccess!(message: success);
        getTasks();
      },
    );
  }

  Future<void> restoreTask({
    required int id,
    Function({required String message})? onSuccess,
    Function({required String message})? onError,
  }) async {
    RestoreArchiveTask restoreTask = ref.read(restoreArchiveTaskProvider);
    final result = await restoreTask(id);
    result.fold(
      (failure) {
        onError!(message: failure);
        state = AsyncError(failure, StackTrace.current);
      },
      (success) {
        onSuccess!(message: success);
        getArchiveTask();
      },
    );
  }
}
