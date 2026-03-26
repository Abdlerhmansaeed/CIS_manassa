import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/core/local_storage/hive_client.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/cached_schedule_model.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/student_credentials_model.dart';

abstract interface class AcademicScheduleLocalDataSource {
  Future<void> saveCredentials(StudentCredentialsModel credentials);
  Future<StudentCredentialsModel?> getCredentials();
  Future<void> saveSchedule(CachedScheduleModel cachedSchedule);
  Future<CachedScheduleModel?> getSchedule();
  Future<void> clearAll();
}

@LazySingleton(as: AcademicScheduleLocalDataSource)
class AcademicScheduleLocalDataSourceImpl implements AcademicScheduleLocalDataSource {
  final HiveClient _hiveClient;
  static const String _boxName = 'academic_schedule_box';
  static const String _credentialsKey = 'student_credentials';
  static const String _scheduleKey = 'cached_schedule';

  AcademicScheduleLocalDataSourceImpl(this._hiveClient);

  @override
  Future<void> saveCredentials(StudentCredentialsModel credentials) async {
    try {
      final box = await _hiveClient.openBox(_boxName);
      await box.put(_credentialsKey, jsonEncode(credentials.toJson()));
      Logger.debug('Saved student credentials to Hive');
    } catch (e, stackTrace) {
      Logger.error('Failed to save credentials to Hive', e, stackTrace);
    }
  }

  @override
  Future<StudentCredentialsModel?> getCredentials() async {
    try {
      final box = await _hiveClient.openBox(_boxName);
      final data = box.get(_credentialsKey);
      if (data == null) return null;
      return StudentCredentialsModel.fromJson(jsonDecode(data as String));
    } catch (e, stackTrace) {
      Logger.error('Failed to get credentials from Hive', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> saveSchedule(CachedScheduleModel cachedSchedule) async {
    try {
      final box = await _hiveClient.openBox(_boxName);
      await box.put(_scheduleKey, jsonEncode(cachedSchedule.toJson()));
      Logger.debug('Saved schedule to Hive');
    } catch (e, stackTrace) {
      Logger.error('Failed to save schedule to Hive', e, stackTrace);
    }
  }

  @override
  Future<CachedScheduleModel?> getSchedule() async {
    try {
      final box = await _hiveClient.openBox(_boxName);
      final data = box.get(_scheduleKey);
      if (data == null) return null;
      return CachedScheduleModel.fromJson(jsonDecode(data as String));
    } catch (e, stackTrace) {
      Logger.error('Failed to get schedule from Hive', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _hiveClient.clearBox(_boxName);
    } catch (e, stackTrace) {
      Logger.error('Failed to clear academic schedule box', e, stackTrace);
    }
  }
}
