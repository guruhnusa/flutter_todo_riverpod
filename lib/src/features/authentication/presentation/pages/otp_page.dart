import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:sabani_tech_test/src/core/assets/assets.gen.dart';
import 'package:sabani_tech_test/src/core/routers/router_name.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_provider.dart';

class OtpPage extends HookConsumerWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationProvider);


    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pushReplacement(RouteName.login);
            },
          )),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Lottie.asset(
            Assets.lotties.emailVerification.path,
            height: 250,
            fit: BoxFit.fitHeight,
          ),
          const Text(
            "Email Verification",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Gap(12),
          const Text(
            'Enter the OTP sent to your email',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Gap(28),
          authState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Pinput(
                  length: 6,
                  onCompleted: (pin) {
                    ref
                        .read(authenticationProvider.notifier)
                        .verification(otp: pin);
                  },
                ),
          const Gap(20),
        ],
      ),
    );
  }
}
