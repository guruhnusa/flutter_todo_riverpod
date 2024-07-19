import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/core/extensions/build_context_ext.dart';
import 'package:sabani_tech_test/src/core/helper/buttons.dart';
import 'package:sabani_tech_test/src/core/helper/custom_text_field.dart';
import 'package:sabani_tech_test/src/features/home/data/datasources/local/task_priority.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_parameter.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/file_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/widgets/choose_attachment_widget.dart';
import 'package:sabani_tech_test/src/features/home/presentation/widgets/due_date_widget.dart';

import '../widgets/choose_priority_widget.dart';

class AddTaskPage extends HookConsumerWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = useTextEditingController();
    final TextEditingController descriptionController =
        useTextEditingController();

    final dateinput = useState<String?>(null);

    final selectedPriority = useState<String?>(null);
    final isButtonDisabled = useState<bool>(true);
    final taskState = ref.watch(taskProvider);
    final file = ref.watch(fileProvider);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
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
          const ChooseAttachmentWidget(),
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
                selectedPriority.value == null ||
                file == null ||
                taskState.isLoading,
            height: 45,
            onPressed: () {
              TaskParams params = TaskParams(
                title: titleController.text,
                description: descriptionController.text,
                dueDate: dateinput.value!,
                priority: selectedPriority.value!,
                file: file!,
              );

              ref.read(taskProvider.notifier).createTask(
                    params: params,
                    onSuccess: ({required message}) =>
                        context.showSuccessSnackbar(message),
                    onError: ({required message}) =>
                        context.showErrorSnackbar(message),
                  );
            },
            label: taskState.isLoading ? 'Loading...' : 'Add Task',
          ),
        ],
      ),
    );
  }
}
