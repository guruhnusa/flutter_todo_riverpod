import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/repositories/authentication_repository.dart';

class Logout implements UseCase<String, void> {
  final AuthenticationRepository repository;

  Logout({required this.repository});
  @override
  Future<Either<String, String>> call(void params) {
    return repository.logout();
  }
}
