import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/models/user_model.dart';

abstract class AuthenticationRepository {
  Future<Either<String, String>> login(
      {required String email, required String password});
  Future<Either<String, String>> register(
      {required String name, required String email, required String password});
  Future<Either<String, UserModel>> getUser();
  Future<Either<String, String>> verification({required String otp});
  Future<Either<String, String>> verificationAgain({required String email});
  Future<Either<String, String>> logout();
}
