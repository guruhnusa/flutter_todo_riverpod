import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/verification.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_repository_provider.dart';

part 'verification_provider.g.dart';

@riverpod
Verification verification(VerificationRef ref) {
  return Verification(
    repository: ref.read(authenticationRepositoryProvider),
  );
}
