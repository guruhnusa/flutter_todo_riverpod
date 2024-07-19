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
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();

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

    final isButtonDisabled = useState<bool>(true);

    void updateButtonState() {
      isButtonDisabled.value =
          emailController.text.isEmpty || passwordController.text.isEmpty;
    }

    useEffect(
      () {
        emailController.addListener(updateButtonState);
        passwordController.addListener(updateButtonState);
        return () {
          emailController.removeListener(updateButtonState);
          passwordController.removeListener(updateButtonState);
        };
      },
      [emailController, passwordController],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                disabled: authState.isLoading ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty,
                onPressed: () {
                  ref.read(authenticationProvider.notifier).login(
                      email: emailController.text,
                      password: passwordController.text);
                },
                label: authState.isLoading ? 'Loading...' : 'Login',
              ),
              const Gap(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(RouteName.register);
                    },
                    child: const Text(
                      ' Sign Up',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const Gap(12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Your Email is Not Verified? '),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(RouteName.verificationEmail);
                    },
                    child: const Text(
                      'Verify Now',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
