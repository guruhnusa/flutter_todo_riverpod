import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/repositories/authentication_repository.dart';

class Login implements UseCase<String, LoginParams> {
  final AuthenticationRepository repository;

  Login({required this.repository});
  @override
  Future<Either<String, String>> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}
