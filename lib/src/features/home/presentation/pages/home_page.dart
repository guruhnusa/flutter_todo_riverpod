import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/core/extensions/build_context_ext.dart';
import 'package:sabani_tech_test/src/core/helper/buttons.dart';
import 'package:sabani_tech_test/src/core/helper/custom_text_field.dart';
import 'package:sabani_tech_test/src/core/routers/router_name.dart';
import 'package:sabani_tech_test/src/core/utils/constant/colors.dart';
import 'package:sabani_tech_test/src/features/home/data/datasources/local/task_filter.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/task_provider.dart';
import 'package:sabani_tech_test/src/features/home/presentation/widgets/card_task_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/header_profile_widget.dart';
import '../widgets/shimmer_card_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndexStatus = useState<int>(0);
    final selectedValueStatus = useState<String?>('all');

    final taskState = ref.watch(taskProvider);
    final searchController = useTextEditingController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(taskProvider.notifier).getTasks();
      });
      return null;
    }, []);

    void onCategoryTap(int index) {
      selectedIndexStatus.value = index;

      String status = 'all';
      switch (index) {
        case 0:
          status = taskFilter[index].value;
          break;
        case 1:
          status = taskFilter[index].value;
          break;
        case 2:
          status = taskFilter[index].value;
          break;
      }
      ref.read(taskProvider.notifier).filterStatusTask(status: status);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryYellow,
          onPressed: () {
            context.pushNamed(RouteName.addTask);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Gap(20),
            const HeaderProfile(),
            const Gap(20),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: taskFilter.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedIndexStatus.value = index;
                      selectedValueStatus.value = taskFilter[index].value;
                      onCategoryTap(index);
                      searchController.clear();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndexStatus.value == index
                            ? AppColors.primaryPurple
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          taskFilter[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedIndexStatus.value == index
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: taskState.when(
                data: (data) {
                  return Row(
                    children: [
                      Flexible(
                        child: CustomTextField(
                          controller: searchController,
                          label: 'Search Task by Title & Description',
                          onChanged: (value) {
                            ref
                                .read(taskProvider.notifier)
                                .searchTask(query: value);
                          },
                        ),
                      ),
                      const Gap(8),
                      const Icon(Icons.search),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const SizedBox.shrink();
                },
                loading: () {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 50,
                      width: context.deviceWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(12),
            Expanded(
              child: taskState.when(
                skipLoadingOnRefresh: true,
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
                              task: task,
                              isTap: true,
                            );
                          },
                        );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Button.filled(
                        onPressed: () {
                          ref.read(taskProvider.notifier).getTasks();
                        },
                        label: 'Retry',
                      ),
                    ),
                  );
                },
                loading: () {
                  return const ShimmerCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
