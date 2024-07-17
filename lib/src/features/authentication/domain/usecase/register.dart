import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/repositories/authentication_repository.dart';

class Register implements UseCase<String, RegisterParams> {
  final AuthenticationRepository repository;

  Register({required this.repository});
  @override
  Future<Either<String, String>> call(RegisterParams params) {
    return repository.register(name: params.name,email: params.email, password: params.password);
  }
}

class RegisterParams {
  final String name;

  final String email;
  final String password;
  RegisterParams({required this.name,required this.email, required this.password});
}
