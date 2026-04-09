import 'package:mansaa_app/core/error_handling/enums/app_error_code.dart';
import 'package:mansaa_app/core/error_handling/exceptions/app_exception.dart';
import 'package:mansaa_app/core/error_handling/exceptions/cache_exception.dart';
import 'package:mansaa_app/core/error_handling/exceptions/network_exception.dart';
import 'package:mansaa_app/core/error_handling/exceptions/parse_exception.dart';
import 'package:mansaa_app/core/error_handling/exceptions/server_exception.dart';
import 'package:mansaa_app/core/error_handling/failures/cache_failure.dart';
import 'package:mansaa_app/core/error_handling/failures/failure.dart';
import 'package:mansaa_app/core/error_handling/failures/network_failure.dart';
import 'package:mansaa_app/core/error_handling/failures/parse_failure.dart';
import 'package:mansaa_app/core/error_handling/failures/server_failure.dart';

/// الحد الفاصل بين طبقة Data وطبقة Domain.
/// يُحوّل [AppException] إلى [Failure] حاملاً [AppErrorCode] فقط.
Failure mapExceptionToFailure(AppException exception) {
  return switch (exception) {
    // ─── Network exceptions ────────────────────────────────────────
    NoInternetException() =>
      const NetworkFailure(AppErrorCode.noInternet),

    ConnectionTimeoutException() =>
      const NetworkFailure(AppErrorCode.connectionTimeout),

    ReceiveTimeoutException() =>
      const NetworkFailure(AppErrorCode.receiveTimeout),

    UnauthorizedException() =>
      const NetworkFailure(AppErrorCode.unauthorized),

    ForbiddenException() =>
      const NetworkFailure(AppErrorCode.forbidden),

    InternalServerErrorException() =>
      const NetworkFailure(AppErrorCode.internalServerError),

    UnknownNetworkException() =>
      const NetworkFailure(AppErrorCode.unknownNetwork),

    // ─── Server exceptions (Moodle 200-OK with error body) ─────────
    ServerException(errorCode: 'invalidlogin') =>
      const ServerFailure(AppErrorCode.invalidLogin),

    ServerException(errorCode: 'invalidtoken') =>
      const ServerFailure(AppErrorCode.invalidToken),

    ServerException(errorCode: 'serviceunavailable') =>
      const ServerFailure(AppErrorCode.serviceNotAvailable),

    ServerException() =>
      const ServerFailure(AppErrorCode.unknownServerError),

    // ─── Cache exceptions ──────────────────────────────────────────
    CacheException() =>
      const CacheFailure(AppErrorCode.cacheReadError),

    // ─── Parse exceptions ──────────────────────────────────────────
    ParseException() =>
      const ParseFailure(AppErrorCode.parseError),

    // ─── Fallback (AppException is abstract, not sealed) ───────────
    _ => const NetworkFailure(AppErrorCode.unknown),
  };
}
