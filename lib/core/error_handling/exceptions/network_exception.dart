import 'package:mansaa_app/core/error_handling/exceptions/app_exception.dart';

/// الأساس المختوم لجميع استثناءات الشبكة المشتقة من Dio.
sealed class NetworkException extends AppException {
  const NetworkException(super.technicalMessage);
}

/// انتهت مهلة الاتصال بالخادم.
final class ConnectionTimeoutException extends NetworkException {
  const ConnectionTimeoutException(super.technicalMessage);
}

/// انتهت مهلة استقبال الاستجابة من الخادم.
final class ReceiveTimeoutException extends NetworkException {
  const ReceiveTimeoutException(super.technicalMessage);
}

/// لا يوجد اتصال بالإنترنت (SocketException أو مشابه).
final class NoInternetException extends NetworkException {
  const NoInternetException(super.technicalMessage);
}

/// الخادم أرجع HTTP 401 — انتهت الجلسة.
final class UnauthorizedException extends NetworkException {
  const UnauthorizedException(super.technicalMessage);
}

/// الخادم أرجع HTTP 403 — ليس لديك صلاحية.
final class ForbiddenException extends NetworkException {
  const ForbiddenException(super.technicalMessage);
}

/// الخادم أرجع HTTP 5xx — خطأ داخلي في الخادم.
final class InternalServerErrorException extends NetworkException {
  const InternalServerErrorException(super.technicalMessage);
}

/// أي خطأ شبكة آخر غير مصنَّف.
final class UnknownNetworkException extends NetworkException {
  const UnknownNetworkException(super.technicalMessage);
}
