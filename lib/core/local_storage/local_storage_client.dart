abstract interface class LocalStorageClient {
  /// Save non-sensitive data to public storage (SharedPreferences).
  Future<void> saveData({required String key, required String value});

  /// Get non-sensitive data from public storage (SharedPreferences).
  Future<String?> getData({required String key});

  /// Delete data from public storage (SharedPreferences).
  Future<void> deleteData({required String key});

  /// Save sensitive data to secure storage (FlutterSecureStorage).
  Future<void> saveSecureData({required String key, required String value});

  /// Get sensitive data from secure storage (FlutterSecureStorage).
  Future<String?> getSecureData({required String key});

  /// Delete data from secure storage (FlutterSecureStorage).
  Future<void> deleteSecureData({required String key});

  /// Clear all data from both public and secure storage.
  Future<void> clearAll();
}
