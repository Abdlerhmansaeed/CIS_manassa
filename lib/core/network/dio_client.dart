import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_client.dart';
import 'package:mansaa_app/core/network/cis_api_client.dart';
import 'package:mansaa_app/core/network/endpoints/app_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:mansaa_app/core/network/interceptors/logging_interceptor.dart';

import 'package:mansaa_app/core/network/interceptors/auth_interceptor.dart';
import 'package:mansaa_app/core/network/interceptors/moodle_error_interceptor.dart';

@module
abstract class DioClient {
  @Named('moodle_baseUrl')
  @singleton
  String get moodleBaseUrl => AppEndPoints.cisMoodleBaseUrl;

  @Named('services_baseUrl')
  @singleton
  String get servicesBaseUrl => AppEndPoints.cisServicesBaseUrl;

  @lazySingleton
  Dio provideDioClient(
    AuthInterceptor authInterceptor,
    MoodleErrorInterceptor moodleErrorInterceptor, {
    @Named('moodle_baseUrl') required String baseUrl,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5) * 2,
      ),
    );

    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(moodleErrorInterceptor);

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
  ApiClient provideApiClient(
    Dio dio, {
    @Named('moodle_baseUrl') required String baseUrl,
  }) {
    return ApiClient(dio, baseUrl: baseUrl);
  }

  @singleton
  CisApiClient provideCisApiClient(
    Dio dio, {
    @Named('services_baseUrl') required String baseUrl,
  }) {
    return CisApiClient(dio, baseUrl: baseUrl);
  }
}
