import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<String, String>> login(
      {required String email, required String password});
  Future<Either<String, String>> register(
      {required String name, required String email, required String password});
  Future<Either<String, String>> verification({required String otp});
  Future<Either<String, String>> logout();
}
