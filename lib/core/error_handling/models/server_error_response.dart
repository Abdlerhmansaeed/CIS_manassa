/// نموذج بيانات يُمثّل جسم الخطأ المرجَع من خادم Moodle / CIS.
/// الخادم يُرجع HTTP 200 OK مع هذا الجسم عند وجود خطأ منطقي.
///
/// مثال:
/// ```json
/// {
///   "error": "Invalid login, please try again",
///   "errorcode": "invalidlogin",
///   "stacktrace": null,
///   "debuginfo": null
/// }
/// ```
class ServerErrorResponse {
  const ServerErrorResponse({
    required this.error,
    required this.errorCode,
  });

  final String error;
  final String errorCode;

  factory ServerErrorResponse.fromJson(Map<String, dynamic> json) {
    return ServerErrorResponse(
      error: json['error'] as String? ?? 'Unknown server error',
      errorCode: json['errorcode'] as String? ?? 'unknown',
    );
  }

  /// يتحقق إن كان الـ Map يمثل استجابة خطأ من Moodle.
  static bool isErrorResponse(dynamic data) {
    if (data is! Map<String, dynamic>) return false;
    return data.containsKey('errorcode') || data.containsKey('error');
  }
}
