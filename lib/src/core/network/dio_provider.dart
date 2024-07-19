import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/token_manager_provider.dart';

part 'dio_provider.g.dart';

final baseUrl = dotenv.env['BASE_URL'];

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.options.baseUrl = baseUrl!;
  dio.options.connectTimeout = const Duration(milliseconds: 15000);
  dio.options.receiveTimeout = const Duration(milliseconds: 15000);
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Accept'] = 'application/json';
  dio.options.validateStatus = (status) {
    return status == 200 || status == 401 || status == 422;
  };

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        TokenManager tokenManager =
            await ref.watch(tokenManagerProvider.future);
        final authToken = await tokenManager.getToken();
        options.headers['Authorization'] = 'Bearer $authToken';
        options.headers['X-SABANI-APP-KEY'] =
            'RsWXehOWms2XWZktm5JgIkuEGo7Y8jKAkehydeglADOSEcyl8Zm7IfoFnuAxwkF4hyX1Mcx4';
        options.headers['X-SABANI-APP-TYPE'] = 'mobile';
        options.headers['X-SABANI-APP-VERSION'] = '1.0';
        return handler.next(options);
      },
    ),
  );

  if (!kReleaseMode) {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
  }
  return dio;
}
