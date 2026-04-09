import 'package:mansaa_app/core/error_handling/failures/failure.dart';

/// فشل ناتج عن خطأ في التخزين المحلي.
final class CacheFailure extends Failure {
  const CacheFailure(super.code);
}
