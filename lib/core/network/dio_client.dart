import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_client.dart';
import 'package:mansaa_app/core/network/endpoints/app_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:mansaa_app/core/network/interceptors/logging_interceptor.dart';

@module
abstract class DioClient {
  @lazySingleton
  Dio provideDioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoints.cisMoodleBaseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

    return dio;
  }

  @singleton
  ApiClient provideApiClient(Dio dio) {
    return ApiClient(dio);
  }
}
