import 'package:dartz/dartz.dart';
import 'package:sabani_tech_test/src/features/authentication/data/datasources/remote/authentication_remote_datasource.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/models/user_model.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDatasource remoteDatasource;

  AuthenticationRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<String, String>> login(
      {required String email, required String password}) async {
    final result =
        await remoteDatasource.login(email: email, password: password);
    return result.fold(
      (error) => left(error),
      (data) => right(data),
    );
  }

  @override
  Future<Either<String, String>> register(
      {required String name,
      required String email,
      required String password}) async {
    final result = await remoteDatasource.register(
        name: name, email: email, password: password);
    return result.fold(
      (error) => left(error),
      (data) => right(data),
    );
  }

  @override
  Future<Either<String, String>> verification({required String otp}) async {
    final result = await remoteDatasource.verification(otp: otp);
    return result.fold(
      (error) => left(error),
      (data) => right(data),
    );
  }
  
  @override
  Future<Either<String, String>> logout() async{
    final result = await remoteDatasource.logout();
    return result.fold(
      (error) => left(error),
      (data) => right(data),
    );
  }

  @override
  Future<Either<String, UserModel>> getUser() async{
    final result = await remoteDatasource.getUser();
    return result.fold(
      (error) => left(error),
      (data) => right(data),
    );
  }
  
  @override
  Future<Either<String, String>> verificationAgain({required String email}) async{
    final result = await remoteDatasource.verificationAgain(email: email);
    return result.fold(
      (error) => left(error),
      (data) => right(data),
    );
  }
}
