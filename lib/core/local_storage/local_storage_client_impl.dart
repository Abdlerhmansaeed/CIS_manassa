import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: LocalStorageClient)
class LocalStorageClientImpl implements LocalStorageClient {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  LocalStorageClientImpl(this._sharedPreferences, this._secureStorage);

  @override
  Future<void> saveData({required String key, required String value}) async {
    try {
      Logger.debug('Saving public data: $key');
      await _sharedPreferences.setString(key, value);
    } catch (e, stackTrace) {
      Logger.error('Failed to save public data: $key', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<String?> getData({required String key}) async {
    try {
      Logger.debug('Getting public data: $key');
      return _sharedPreferences.getString(key);
    } catch (e, stackTrace) {
      Logger.error('Failed to get public data: $key', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> deleteData({required String key}) async {
    try {
      Logger.debug('Deleting public data: $key');
      await _sharedPreferences.remove(key);
    } catch (e, stackTrace) {
      Logger.error('Failed to delete public data: $key', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> saveSecureData({
    required String key,
    required String value,
  }) async {
    try {
      Logger.debug('Saving secure data: $key');
      await _secureStorage.write(key: key, value: value);
    } catch (e, stackTrace) {
      Logger.error('Failed to save secure data: $key', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<String?> getSecureData({required String key}) async {
    try {
      Logger.debug('Getting secure data: $key');
      return await _secureStorage.read(key: key);
    } catch (e, stackTrace) {
      Logger.error('Failed to get secure data: $key', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> deleteSecureData({required String key}) async {
    try {
      Logger.debug('Deleting secure data: $key');
      await _secureStorage.delete(key: key);
    } catch (e, stackTrace) {
      Logger.error('Failed to delete secure data: $key', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      Logger.warning('Clearing all local storage (public and secure)');
      await Future.wait([
        _sharedPreferences.clear(),
        _secureStorage.deleteAll(),
      ]);
    } catch (e, stackTrace) {
      Logger.error('Failed to clear all storage', e, stackTrace);
      rethrow;
    }
  }
}
