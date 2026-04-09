import 'package:mansaa_app/core/error_handling/exceptions/app_exception.dart';

/// يُرمى عند فشل عمليات القراءة أو الكتابة في التخزين المحلي.
final class CacheException extends AppException {
  const CacheException(super.technicalMessage);
}
