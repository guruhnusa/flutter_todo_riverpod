import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/user_manager_provider.dart';

import '../../../../core/routers/router_name.dart';
import '../../../../core/utils/constant/colors.dart';

class HeaderProfile extends ConsumerWidget {
  const HeaderProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(getCurrentUserProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: AppColors.primaryCream,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(4),
              Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              userState.when(data: (data) {
                return Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }, loading: () {
                return const SizedBox.shrink();
              }, error: (error, stackTrace) {
                return const SizedBox.shrink();
              }),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              context.pushNamed(RouteName.deleteTask);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.restore_from_trash,
                color: Colors.white,
              ),
            ),
          ),
          const Gap(8),
          GestureDetector(
            onTap: () {
              context.pushNamed(RouteName.archiveTask);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.archive,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
