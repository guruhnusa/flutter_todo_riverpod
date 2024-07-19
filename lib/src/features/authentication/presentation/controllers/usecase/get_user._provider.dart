import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/get_user.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/authentication_repository_provider.dart';

part 'get_user._provider.g.dart';

@riverpod
GetUser getUser(GetUserRef ref) {
  return GetUser(repository: ref.read(authenticationRepositoryProvider));
}
