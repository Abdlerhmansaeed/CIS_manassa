import 'package:flutter/material.dart';
import 'package:mansaa_app/core/error_handling/enums/app_error_code.dart';
import 'package:mansaa_app/core/error_handling/failures/failure.dart';
import 'package:mansaa_app/core/extensions/localization_extension.dart';

/// الطبقة الوحيدة في التطبيق المسؤولة عن ترجمة [Failure] إلى رسالة مقروءة.
/// تستخدم الآن AppLocalizations عبر context.l10n لدعم اللغتين العربية والإنجليزية.
extension FailureMessageMapper on Failure {
  String toUserMessage(BuildContext context) {
    final l10n = context.l10n;
    
    return switch (code) {
      // ─── Network ─────────────────────────────────────────────────
      AppErrorCode.noInternet => l10n.noInternet,
      AppErrorCode.connectionTimeout => l10n.connectionTimeout,
      AppErrorCode.receiveTimeout => l10n.receiveTimeout,
      AppErrorCode.unauthorized => l10n.unauthorized,
      AppErrorCode.forbidden => l10n.forbidden,
      AppErrorCode.internalServerError => l10n.internalServerError,
      AppErrorCode.unknownNetwork => l10n.unknownNetwork,

      // ─── Server (Moodle / CIS) ───────────────────────────────────
      AppErrorCode.invalidLogin => l10n.invalidLogin,
      AppErrorCode.invalidToken => l10n.invalidToken,
      AppErrorCode.serviceNotAvailable => l10n.serviceNotAvailable,
      AppErrorCode.unknownServerError => l10n.unknownServerError,

      // ─── Cache ───────────────────────────────────────────────────
      AppErrorCode.cacheReadError => l10n.cacheReadError,
      AppErrorCode.cacheWriteError => l10n.cacheWriteError,


      AppErrorCode.invalidCredentialsForUserGetAccess => l10n.getAccessWrongInfoError,

      // ─── Parse ───────────────────────────────────────────────────
      AppErrorCode.parseError => l10n.parseError,

      // ─── Fallback ────────────────────────────────────────────────
      _ => l10n.somethingWentWrong,
    };
  }
}
