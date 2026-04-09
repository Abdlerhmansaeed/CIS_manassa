import 'package:mansaa_app/core/error_handling/failures/failure.dart';

/// فشل ناتج عن خطأ منطقي من الخادم (200 OK مع errorcode).
final class ServerFailure extends Failure {
  const ServerFailure(super.code);
}
