import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/core/network/dio_provider.dart';
import 'package:sabani_tech_test/src/features/authentication/data/datasources/remote/authentication_remote_datasource.dart';
import 'package:sabani_tech_test/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:sabani_tech_test/src/features/authentication/domain/repositories/authentication_repository.dart';

part 'authentication_repository_provider.g.dart';

@riverpod
AuthenticationRepository authenticationRepository(
    AuthenticationRepositoryRef ref) {
  return AuthenticationRepositoryImpl(
    remoteDatasource: AuthenticationRemoteDatasourceImpl(
      httpClient: ref.read(dioProvider),
    ),
  );
}
