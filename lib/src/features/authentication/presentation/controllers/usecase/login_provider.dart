import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/login.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_repository_provider.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) {
  return Login(
    repository: ref.read(authenticationRepositoryProvider),
  );
}
