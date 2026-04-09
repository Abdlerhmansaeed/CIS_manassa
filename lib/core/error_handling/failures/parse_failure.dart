import 'package:mansaa_app/core/error_handling/failures/failure.dart';

/// فشل ناتج عن خطأ في تحليل استجابة الخادم أو HTML.
final class ParseFailure extends Failure {
  const ParseFailure(super.code);
}
