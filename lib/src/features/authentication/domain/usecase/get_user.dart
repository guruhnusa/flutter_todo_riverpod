import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/models/user_model.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/repositories/authentication_repository.dart';

class GetUser implements UseCase<UserModel, void> {
  final AuthenticationRepository repository;

  GetUser({required this.repository});
  @override
  Future<Either<String, UserModel>> call(void params) {
    return repository.getUser();
  }
}
