import 'package:mansaa_app/core/error_handling/exceptions/app_exception.dart';

/// يُرمى عندما يُرجع الخادم HTTP 2xx لكن جسم الاستجابة يحتوي على خطأ.
/// هذا سلوك Moodle الخاص: 200 OK مع {"error": "...", "errorcode": "..."}.
final class ServerException extends AppException {
  const ServerException({
    required this.errorCode,
    required String serverMessage,
  }) : super(serverMessage);

  /// رمز الخطأ الخام من الخادم مثل "invalidlogin".
  final String errorCode;
}
