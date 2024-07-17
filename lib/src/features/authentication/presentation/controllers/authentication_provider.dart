import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/core/routers/router_name.dart';
import 'package:sabani_tech_test/src/core/routers/routers.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/login.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/logout.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/register.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/verification.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/token_manager_provider.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/usecase/login_provider.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/usecase/logout_provider.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/usecase/register_provider.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/usecase/verification_provider.dart';
import 'package:sabani_tech_test/src/features/main/presentation/controllers/selected_index_provider.dart';

part 'authentication_provider.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    Login login = ref.read(loginProvider);
    final result = await login(LoginParams(email: email, password: password));
    return result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) {
        state = AsyncData(data);
      },
    );
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    ref.invalidateSelf();

    state = const AsyncLoading();
    Register register = ref.read(registerProvider);
    final result = await register(
        RegisterParams(name: name, email: email, password: password));
    return result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) {
        state = AsyncData(data);
      },
    );
  }

  Future<void> verification({required String otp}) async {
    state = const AsyncLoading();
    Verification verif = ref.read(verificationProvider);
    final result = await verif.call(otp);
    return result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) async {
        TokenManager tokenManager =
            await ref.watch(tokenManagerProvider.future);
        await tokenManager.saveToken(data);
        state = const AsyncData('Verification Success');
        ref.read(routerProvider).pushReplacementNamed(RouteName.main);
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    Logout logout = ref.read(logoutProvider);
    final result = await logout.call(null);
    return result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) async {
        TokenManager tokenManager =
            await ref.watch(tokenManagerProvider.future);
        await tokenManager.removeToken();
        ref.invalidate(selectedIndexNavBarProvider);
        state = const AsyncData('Logout Success');
        ref.read(routerProvider).pushReplacementNamed(RouteName.login);
      },
    );
  }
}
