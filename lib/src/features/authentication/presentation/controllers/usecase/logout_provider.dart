import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/logout.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_repository_provider.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) {
  return Logout(repository: ref.read(authenticationRepositoryProvider));
}
