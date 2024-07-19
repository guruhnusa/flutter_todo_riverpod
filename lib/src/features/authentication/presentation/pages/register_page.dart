import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/core/helper/buttons.dart';
import 'package:sabani_tech_test/src/core/helper/custom_text_field.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_provider.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = useTextEditingController();
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();

    final authState = ref.watch(authenticationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Name',
                obscureText: false,
              ),
              const Gap(16.0),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                obscureText: false,
              ),
              const Gap(16.0),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: true,
              ),
              const Gap(20.0),
              Button.filled(
                disabled: authState.isLoading,
                onPressed: () {
                  ref.read(authenticationProvider.notifier).register(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
                label: authState.isLoading ? 'Loading...' : 'Register',
              ),
              const Gap(20.0),
            ],
          ),
        ),
      ),
    );
  }
}
