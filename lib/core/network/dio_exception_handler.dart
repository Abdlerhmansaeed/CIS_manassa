import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mansaa_app/core/error_handling/exceptions/app_exception.dart';
import 'package:mansaa_app/core/error_handling/exceptions/network_exception.dart';
import 'package:mansaa_app/core/error_handling/exceptions/server_exception.dart';
import 'package:mansaa_app/core/error_handling/models/server_error_response.dart';
import 'package:mansaa_app/core/helpers/logger.dart';

/// يُغلِّف أي استدعاء Retrofit/Dio ويُحوِّل الاستثناءات إلى [AppException].
///
/// يعالج أيضاً سلوك Moodle الخاص: HTTP 200 OK مع جسم خطأ.
Future<T> safeApiCall<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e, st) {
    Logger.error('DioException caught', e, st, 'DioHandler');
    throw _handleDioException(e);
  } on SocketException catch (e, st) {
    Logger.error('SocketException — no internet', e, st, 'DioHandler');
    throw NoInternetException(e.message);
  } catch (e, st) {
    if (e is AppException || e is FormatException) rethrow;
    Logger.error('Unexpected error in safeApiCall', e, st, 'DioHandler');
    throw UnknownNetworkException(e.toString());
  }
}

/// يُحوِّل [DioException] إلى استثناء مُصنَّف من هيكلية [AppException].
NetworkException _handleDioException(DioException e) {
  // فحص جسم الاستجابة لمعرفة إن كان خطأ Moodle (200 OK مع errorcode)
  _checkForServerErrorBody(e);

  return switch (e.type) {
    DioExceptionType.connectionTimeout =>
      ConnectionTimeoutException(e.message ?? 'Connection timeout'),

    DioExceptionType.receiveTimeout =>
      ReceiveTimeoutException(e.message ?? 'Receive timeout'),

    DioExceptionType.sendTimeout =>
      ConnectionTimeoutException(e.message ?? 'Send timeout'),

    DioExceptionType.connectionError =>
      NoInternetException(e.message ?? 'No internet connection'),

    DioExceptionType.badResponse => _handleBadResponse(e),

    _ => UnknownNetworkException(e.message ?? 'Unknown network error'),
  };
}

/// يعالج حالة HTTP 4xx / 5xx.
NetworkException _handleBadResponse(DioException e) {
  final statusCode = e.response?.statusCode;

  return switch (statusCode) {
    401 => const UnauthorizedException('HTTP 401 — Unauthorized'),
    403 => const ForbiddenException('HTTP 403 — Forbidden'),
    final int code when code >= 500 => InternalServerErrorException(
        'HTTP $code — Internal server error',
      ),
    _ => UnknownNetworkException('HTTP $statusCode — Unexpected response'),
  };
}

/// يتحقق إن كانت استجابة 200 OK تحمل جسم خطأ من Moodle ويرمي [ServerException].
void _checkForServerErrorBody(DioException e) {
  final data = e.response?.data;
  if (ServerErrorResponse.isErrorResponse(data)) {
    final serverError = ServerErrorResponse.fromJson(
      data as Map<String, dynamic>,
    );
    throw ServerException(
      errorCode: serverError.errorCode,
      serverMessage: serverError.error,
    );
  }
}
