import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/core/extensions/build_context_ext.dart';
import 'package:sabani_tech_test/src/core/helper/buttons.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_provider.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
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
                )),
            const Gap(60),
            Button.filled(
              disabled: authState.isLoading,
              onPressed: () {
                ref.read(authenticationProvider.notifier).logout();
              },
              label: authState.isLoading ? 'Loading...' : 'Logout',
            )
          ],
        ));
  }
}
