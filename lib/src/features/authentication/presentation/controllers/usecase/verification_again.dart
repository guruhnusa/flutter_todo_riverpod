import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/verification_again.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_repository_provider.dart';

part 'verification_again.g.dart';


@riverpod
VerificationAgain verificationAgain(VerificationAgainRef ref) {
  return VerificationAgain(
      repository: ref.read(authenticationRepositoryProvider));
}
