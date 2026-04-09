import 'package:mansaa_app/core/error_handling/failures/failure.dart';

/// فشل ناتج عن خطأ في الشبكة أو Dio.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.code);
}
