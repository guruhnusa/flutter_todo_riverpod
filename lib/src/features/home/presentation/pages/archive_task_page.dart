import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/widgets/card_task_widget.dart';
import 'package:sabani_tech_test/src/features/home/presentation/widgets/shimmer_card_widget.dart';

class ArchiveTaskPage extends HookConsumerWidget {
  const ArchiveTaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(taskProvider.notifier).getArchiveTask();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Archive Task',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              context.pop();
              ref.read(taskProvider.notifier).getTasks();
            },
          )),
      body: taskState.when(
        data: (data) {
          return data.isEmpty
              ? const Center(
                  child: Text('No Data'),
                )
              : ListView.separated(
                  itemCount: data.length,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 15,
                  ),
                  separatorBuilder: (context, index) => const Gap(8),
                  itemBuilder: (context, index) {
                    final task = data[index];
                    return CardTask(
                      isRestore: true,
                      task: task,
                    );
                  },
                );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        },
        loading: () {
          return const ShimmerCard();
        },
      ),
    );
  }
}
