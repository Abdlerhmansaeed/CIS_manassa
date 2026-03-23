import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/constants/app_keys.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client.dart';

@singleton
class UserSession {
  final LocalStorageClient _storageClient;

  String? _token;
  int? _userId;

  UserSession(this._storageClient);

  /// Initialize session from local storage.
  Future<void> init() async {
    _token = await _storageClient.getSecureData(key: AppKeys.token);
    final userIdStr = await _storageClient.getSecureData(key: AppKeys.userId);
    if (userIdStr != null) {
      _userId = int.tryParse(userIdStr);
    }
  }

  /// Sets the token in memory only.
  void setToken(String token) {
    _token = token;
  }

  /// Save session to memory and secure storage.
  Future<void> saveSession({required String token, required int userId}) async {
    _token = token;
    _userId = userId;

    await Future.wait([
      _storageClient.saveSecureData(key: AppKeys.token, value: token),
      _storageClient.saveSecureData(key: AppKeys.userId, value: userId.toString()),
    ]);
  }

  /// returns true if the user is logged in (has a token).
  bool get isLoggedIn => _token != null;

  String? getToken() => _token;

  int? getUserId() => _userId;

  /// Clear session from memory and secure storage.
  Future<void> clearSession() async {
    _token = null;
    _userId = null;

    await Future.wait([
      _storageClient.deleteSecureData(key: AppKeys.token),
      _storageClient.deleteSecureData(key: AppKeys.userId),
    ]);
  }
}
