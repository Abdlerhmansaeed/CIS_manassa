import 'package:mansaa_app/core/error_handling/enums/app_error_code.dart';

/// طبقة Domain — الأساس المختوم لجميع الإخفاقات.
/// يحمل فقط [AppErrorCode] — لا نصوص، لا ترجمة، لا تبعيات UI.
abstract class Failure {
  const Failure(this.code);

  final AppErrorCode code;
}
