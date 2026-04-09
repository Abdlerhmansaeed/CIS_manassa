import 'package:flutter/material.dart';
import 'package:mansaa_app/l10n/app_localizations.dart';

/// تمديد لـ BuildContext لتسهيل الوصول إلى الترجمة.
/// استخدام: context.l10n.keyName
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
