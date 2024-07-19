import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/core/helper/buttons.dart';
import 'package:sabani_tech_test/src/core/helper/custom_text_field.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_provider.dart';

class VerifiyEmailPage extends HookConsumerWidget {
  const VerifiyEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final authState = ref.watch(authenticationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: emailController,
              label: 'Email',
            ),
            const Gap(16),
            Button.filled(
              disabled: authState.isLoading,
              onPressed: () {
                ref.read(authenticationProvider.notifier).verificationAgain(
                      email: emailController.text,
                    );
              },
              label: authState.isLoading
                  ? 'Loading...'
                  : 'Send Verification Email',
            ),
          ],
        ),
      ),
    );
  }
}
