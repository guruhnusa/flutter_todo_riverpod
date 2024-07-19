// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/core/extensions/build_context_ext.dart';
import 'package:sabani_tech_test/src/core/helper/buttons.dart';
import 'package:sabani_tech_test/src/core/helper/custom_text_field.dart';
import 'package:sabani_tech_test/src/core/network/file_downloader.dart';
import 'package:sabani_tech_test/src/core/utils/constant/colors.dart';
import 'package:sabani_tech_test/src/features/home/data/datasources/local/task_priority.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_model.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_parameter.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/widgets/due_date_widget.dart';

import '../widgets/choose_priority_widget.dart';

class EditTaskPage extends HookConsumerWidget {
  final TaskModel task;
  const EditTaskPage({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = useTextEditingController(
      text: task.title,
    );
    final TextEditingController descriptionController =
        useTextEditingController(
      text: task.description,
    );

    final dateinput = useState<String?>(
      task.dueDate,
    );

    final selectedPriority = useState<String?>(
      task.taskPriority,
    );
    final isButtonDisabled = useState<bool>(true);
    final taskState = ref.watch(taskProvider);

    final statusTask = useState<bool>(
      task.statusTask == 'completed' ? true : false,
    );

    void updateButtonState() {
      isButtonDisabled.value =
          titleController.text.isEmpty || descriptionController.text.isEmpty;
    }

    useEffect(
      () {
        titleController.addListener(updateButtonState);
        descriptionController.addListener(updateButtonState);
        return () {
          titleController.removeListener(updateButtonState);
          descriptionController.removeListener(updateButtonState);
        };
      },
      [titleController, descriptionController],
    );

    final isLoading = useState<bool>(false);

    Future<void> downloadFile() async {
      isLoading.value = true;
      final isSuccess = await FileDownloader().startDownloading(
        file: task.file!,
      );
      if (isSuccess) {
        if (context.mounted) {
          context.showSuccessSnackbar(
              'Download Success check your download folder');
        }
        isLoading.value = false;
      } else {
        if (context.mounted) {
          context.showErrorSnackbar('Download Failed');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomTextField(
            controller: titleController,
            label: 'Title',
            obscureText: false,
            isRequired: true,
          ),
          const Gap(8),
          CustomTextField(
            controller: descriptionController,
            label: 'Description',
            obscureText: false,
            isRequired: true,
          ),
          const Gap(12),
          DueDataTextField(
            dateinput: dateinput,
          ),
          const Gap(12),
          ChoosePriority(
            selectedPriority: selectedPriority,
            taskPriority: taskPriority,
          ),
          const Gap(12),
          const Text(
            'Status ',
            style: TextStyle(
              color: Color(0xFF484848),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Gap(12),
          CheckboxListTile(
            value: statusTask.value,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Completed',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (bool? value) {
              statusTask.value = value!;
              TaskParams params = TaskParams(
                id: task.id,
                title: titleController.text,
                description: descriptionController.text,
                dueDate: dateinput.value!,
                priority: selectedPriority.value!,
                status: statusTask.value ? 'Completed' : 'to_do',
              );
              ref.read(taskProvider.notifier).updateTask(
                    params: params,
                    onSuccess: ({required message}) =>
                        context.showSuccessSnackbar(message),
                    onError: ({required message}) =>
                        context.showErrorSnackbar(message),
                  );
            },
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Attachment ',
                style: TextStyle(
                  color: Color(0xFF484848),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Gap(12),
              GestureDetector(
                onTap: () async {
                  downloadFile();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isLoading.value ? 'Downloading...' : 'Download Attachment',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
          const Gap(20),
          const Text(
            '* Required',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
          const Gap(20),
          Button.filled(
            disabled: titleController.text.isEmpty ||
                descriptionController.text.isEmpty ||
                dateinput.value == null ||
                selectedPriority.value == null,
            height: 45,
            onPressed: () {
              TaskParams params = TaskParams(
                id: task.id,
                title: titleController.text,
                description: descriptionController.text,
                dueDate: dateinput.value!,
                priority: selectedPriority.value!,
                status: statusTask.value ? 'Completed' : 'to_do',
              );

              ref.read(taskProvider.notifier).updateTask(
                    params: params,
                    onSuccess: ({required message}) =>
                        context.showSuccessSnackbar(message),
                    onError: ({required message}) =>
                        context.showErrorSnackbar(message),
                  );
            },
            label: taskState.isLoading ? 'Loading...' : 'Update',
          ),
          const Gap(30),
          Button.outlined(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Are you sure you want to delete this task?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(taskProvider.notifier).deleteTask(
                                          id: task.id!,
                                          onSuccess: ({required message}) {
                                            context
                                                .showSuccessSnackbar(message);
                                            context.pop();
                                          },
                                          onError: ({required message}) {
                                            context.showErrorSnackbar(message);
                                            context.pop();
                                          },
                                        );
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            label: 'Delete',
          )
        ],
      ),
    );
  }
}
