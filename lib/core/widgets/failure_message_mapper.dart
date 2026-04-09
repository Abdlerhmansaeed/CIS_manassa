import 'package:flutter/material.dart';
import 'package:mansaa_app/core/error_handling/enums/app_error_code.dart';
import 'package:mansaa_app/core/error_handling/failures/failure.dart';

/// الطبقة الوحيدة في التطبيق المسؤولة عن ترجمة [Failure] إلى رسالة مقروءة.
/// عند إضافة الـ Localization: غيّر هذا الملف فقط.
extension FailureMessageMapper on Failure {
  String toUserMessage(BuildContext context) {
    return switch (code) {
      // ─── Network ─────────────────────────────────────────────────
      AppErrorCode.noInternet =>
        'No internet connection. Please check your network.',
      AppErrorCode.connectionTimeout =>
        'Connection timed out. Please try again.',
      AppErrorCode.receiveTimeout =>
        'Server took too long to respond. Please try again.',
      AppErrorCode.unauthorized =>
        'Your session has expired. Please log in again.',
      AppErrorCode.forbidden =>
        'You do not have permission to access this resource.',
      AppErrorCode.internalServerError =>
        'The server is temporarily unavailable. Please try again later.',
      AppErrorCode.unknownNetwork =>
        'A network error occurred. Please try again.',

      // ─── Server (Moodle / CIS) ───────────────────────────────────
      AppErrorCode.invalidLogin =>
        'Invalid credentials. Please check your Student ID and password.',
      AppErrorCode.invalidToken =>
        'Your session is invalid. Please log in again.',
      AppErrorCode.serviceNotAvailable =>
        'This service is currently unavailable.',
      AppErrorCode.unknownServerError =>
        'An unexpected server error occurred. Please try again.',

      // ─── Cache ───────────────────────────────────────────────────
      AppErrorCode.cacheReadError =>
        'Could not load saved data. Please try again.',
      AppErrorCode.cacheWriteError =>
        'Could not save data locally. Please try again.',

      // ─── Parse ───────────────────────────────────────────────────
      AppErrorCode.parseError =>
        'Received an unexpected response from the server.',

      // ─── Fallback ────────────────────────────────────────────────
      _ => 'Something went wrong. Please try again.',
    };
  }
}
