import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/core/extensions/build_context_ext.dart';
import 'package:sabani_tech_test/src/core/helper/buttons.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_provider.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/user_manager_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationProvider);

    ref.listen(
      authenticationProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          context.showSuccessSnackbar(next.value!);
        } else if (next is AsyncError) {
          context.showErrorSnackbar(next.error.toString());
        }
      },
    );
    final userState = ref.watch(getCurrentUserProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 160,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const Gap(24),
              userState.when(
                data: (data) {
                  return Center(
                    child: Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const SizedBox.shrink();
                },
                loading: () {
                  return const SizedBox.shrink();
                },
              ),
              const Gap(24),
              Button.filled(
                disabled: authState.isLoading,
                onPressed: () {
                  ref.read(authenticationProvider.notifier).logout();
                },
                label: authState.isLoading ? 'Loading...' : 'Logout',
              )
            ],
          ),
        ),
      ),
    );
  }
}
