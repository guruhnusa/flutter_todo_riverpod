import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/register.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_repository_provider.dart';
part 'register_provider.g.dart';

@riverpod
Register register(RegisterRef ref) {
  return Register(repository: ref.read(authenticationRepositoryProvider));
}