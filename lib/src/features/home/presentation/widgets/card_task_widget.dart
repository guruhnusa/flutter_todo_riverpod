import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sabani_tech_test/src/core/extensions/build_context_ext.dart';
import 'package:sabani_tech_test/src/core/routers/router_name.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_model.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_provider.dart';

import '../../../../core/utils/constant/colors.dart';

class CardTask extends ConsumerWidget {
  final TaskModel task;
  final bool isRestore;
  final bool isDelete;
  final bool isTap;

  const CardTask({
    super.key,
    required this.task,
    this.isRestore = false,
    this.isDelete = false,
    this.isTap = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime date = DateTime.parse(task.dueDate!);
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);

    return GestureDetector(
      onTap: () {
        isTap == true
            ? context.pushNamed(
                RouteName.editTask,
                extra: task,
              )
            : null;
      },
      child: Card(
        child: Container(
          width: context.deviceWidth,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: task.statusTask == 'to_do'
                          ? Colors.red
                          : task.statusTask == 'completed'
                              ? Colors.green
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      task.statusTask == 'to_do'
                          ? 'To Do'
                          : task.statusTask == 'completed'
                              ? 'Completed'
                              : '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: task.taskPriority == 'urgently'
                          ? Colors.red
                          : task.taskPriority == 'high'
                              ? Colors.orange
                              : task.taskPriority == 'normal'
                                  ? Colors.yellow
                                  : Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      task.taskPriority!.substring(0, 1).toUpperCase() +
                          task.taskPriority!.substring(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(),
                  isDelete == true
                      ? IconButton(
                          onPressed: () {
                            ref.read(taskProvider.notifier).restoreDeleteTask(
                                  id: task.id!,
                                  onSuccess: ({required message}) =>
                                      context.showSuccessSnackbar(message),
                                  onError: ({required message}) =>
                                      context.showErrorSnackbar(message),
                                );
                          },
                          icon: const Icon(
                            Icons.restore_from_trash,
                            size: 24,
                            color: AppColors.primaryGreen,
                          ),
                        )
                      : isRestore == true
                          ? IconButton(
                              onPressed: () {
                                ref.read(taskProvider.notifier).restoreTask(
                                      id: task.id!,
                                      onSuccess: ({required message}) =>
                                          context.showSuccessSnackbar(message),
                                      onError: ({required message}) =>
                                          context.showErrorSnackbar(message),
                                    );
                              },
                              icon: const Icon(
                                Icons.unarchive,
                                size: 24,
                                color: AppColors.primaryGreen,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                ref.read(taskProvider.notifier).archiveTask(
                                      id: task.id!,
                                      onSuccess: ({required message}) =>
                                          context.showSuccessSnackbar(message),
                                      onError: ({required message}) =>
                                          context.showErrorSnackbar(message),
                                    );
                              },
                              icon: const Icon(
                                Icons.archive,
                                size: 24,
                                color: AppColors.primaryCream,
                              ),
                            )
                ],
              ),
              Text(
                task.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const Gap(8),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                task.description ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const Gap(12),
              const Text(
                'Attachment',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const Gap(4),
              GestureDetector(
                onTap: () {
                  //show dialog to show attachment
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Attachment'),
                        content: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://dev-api-flutter.mjscode.pro/storage/archive/${task.file}',
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.attach_file,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(8),
            ],
          ),
        ),
      ),
    );
  }
}
