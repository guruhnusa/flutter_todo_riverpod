import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sabani_tech_test/src/core/utils/errors/dio_error.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/models/user_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<Either<String, String>> login(
      {required String email, required String password});
  Future<Either<String, String>> register(
      {required String name, required String email, required String password});
  Future<Either<String, UserModel>> getUser();

  Future<Either<String, String>> verification({required String otp});
  Future<Either<String, String>> verificationAgain({required String email});
  Future<Either<String, String>> logout();
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  final Dio httpClient;

  AuthenticationRemoteDatasourceImpl({required this.httpClient});
  @override
  Future<Either<String, String>> login(
      {required String email, required String password}) async {
    try {
      final response = await httpClient.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }

  @override
  Future<Either<String, String>> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await httpClient.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }

  @override
  Future<Either<String, String>> verification({required String otp}) async {
    try {
      final response = await httpClient.post(
        '/auth/otp/login',
        data: {
          'otp': otp,
        },
      );
      if (response.statusCode == 200) {
        return Right(response.data['data']["token"]);
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }

  @override
  Future<Either<String, String>> logout() async {
    try {
      final response = await httpClient.post(
        '/auth/logout',
      );
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }

  @override
  Future<Either<String, UserModel>> getUser() async {
    try {
      final response = await httpClient.get(
        '/auth/user/profile',
      );
      if (response.statusCode == 200) {
        return Right(
          UserModel.fromJson(
            response.data,
          ),
        );
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }

  @override
  Future<Either<String, String>> verificationAgain(
      {required String email}) async {
    try {
      final response = await httpClient.post(
        '/verify/email/again',
        data: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        return Right(
          response.data['message'],
        );
      } else {
        return Left(
          response.data['message'],
        );
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      throw error;
    }
  }
}
