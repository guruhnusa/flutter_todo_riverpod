import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

    final time = useState(30);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (time.value == 0) {
          timer.cancel();
        } else {
          time.value = time.value - 1;
        }
      });
      return timer.cancel;
    }, [time]);
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
          const Gap(14),
          Center(
            child: time.value == 0
                ? TextButton(
                    onPressed: () {
                      time.value = 30;
                    },
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Resend OTP in ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '${time.value} seconds',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
