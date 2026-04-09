/// طبقة البيانات — الأساس المختوم لجميع استثناءات التطبيق.
/// الرسالة هنا تقنية فقط (للـ Logger) ولا تُعرض للمستخدم أبداً.
abstract class AppException implements Exception {
  const AppException(this.technicalMessage);

  final String technicalMessage;

  @override
  String toString() => '$runtimeType: $technicalMessage';
}
