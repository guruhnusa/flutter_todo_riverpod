import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/usecase/get_user.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/usecase/get_user._provider.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/user_manager_provider.dart';

part 'save_user_provider.g.dart';

@riverpod
FutureOr<void> saveUser(SaveUserRef ref) async {
  GetUser getUser = await ref.watch(getUserProvider);
  final result = await getUser.call(null);
  return result.fold(
    (error) {
      throw error;
    },
    (data) async {
      UserManager user = await ref.watch(userManagerProvider.future);
      await user.saveUser(data);
    },
  );
}
