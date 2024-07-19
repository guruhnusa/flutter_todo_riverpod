import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/core/utils/usecases/usecases.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/repositories/authentication_repository.dart';

class VerificationAgain implements UseCase<String, String> {
  final AuthenticationRepository repository;

  VerificationAgain({required this.repository});
  @override
  Future<Either<String, String>> call(String params) {
    return repository.verificationAgain(email: params);
  }
}
