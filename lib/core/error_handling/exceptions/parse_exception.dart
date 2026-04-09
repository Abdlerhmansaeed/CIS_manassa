import 'package:mansaa_app/core/error_handling/exceptions/app_exception.dart';

/// يُرمى عند فشل تحليل (parse) استجابة الخادم أو HTML.
final class ParseException extends AppException {
  const ParseException(super.technicalMessage);
}
