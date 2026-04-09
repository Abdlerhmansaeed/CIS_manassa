/// رموز الأخطاء القابلة للقراءة آلياً عبر كامل التطبيق.
/// طبقة Domain تحمل هذا فقط — بدون أي نصوص للمستخدم.
/// الترجمة حصراً في طبقة Presentation عبر FailureMessageMapper.
enum AppErrorCode {
  // ─── Network ───────────────────────────────────────────
  noInternet,
  connectionTimeout,
  receiveTimeout,
  unauthorized,
  forbidden,
  internalServerError,
  unknownNetwork,

  // ─── Server (Moodle / CIS API) ─────────────────────────
  invalidLogin,
  invalidToken,
  serviceNotAvailable,
  unknownServerError,
  invalidCredentialsForUserGetAccess,
  // ─── Cache (Hive / SharedPreferences) ──────────────────
  cacheReadError,
  cacheWriteError,

  // ─── Parse ─────────────────────────────────────────────
  parseError,

  // ─── Generic fallback ──────────────────────────────────
  unknown,
}
