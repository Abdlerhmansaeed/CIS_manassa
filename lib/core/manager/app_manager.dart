import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/constants/app_keys.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client.dart';
import 'package:mansaa_app/core/manager/app_manager_state.dart';
import 'package:mansaa_app/core/network/session/user_session.dart';

@singleton
class AppManager extends Cubit<AppManagerState> {
  AppManager(this._storageClient, this._userSession)
    : super(const AppManagerState());

  final LocalStorageClient _storageClient;
  final UserSession _userSession;

  Future<void> initUserSession() async {
    // These functions return Future<void>
    await Future.wait([
      _getUserThemeMode(),
      _userSession.init(),
    ]);

    // These functions return Future<String?>
    final loginData = await Future.wait([
      _storageClient.getData(key: AppKeys.rememberMe),
      _storageClient.getSecureData(key: AppKeys.userCode),
      _storageClient.getSecureData(key: AppKeys.userPassword),
    ]);

    emit(
      state.copyWith(
        isRememberMe: loginData[0] == 'true',
        userCode: loginData[1],
        userPassword: loginData[2],
        isLoggedIn: _userSession.isLoggedIn,
      ),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    _storageClient.saveData(key: AppKeys.themeMode, value: themeMode.name);
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> _getUserThemeMode() async {
    final themeModeStr = await _storageClient.getData(key: AppKeys.themeMode);
    if (themeModeStr != null) {
      try {
        final userSavedThemeMode = ThemeMode.values.firstWhere(
          (e) => e.name == themeModeStr,
          orElse: () => ThemeMode.system,
        );
        emit(state.copyWith(themeMode: userSavedThemeMode));
      } catch (_) {
        emit(state.copyWith(themeMode: ThemeMode.system));
      }
    } else {
      emit(state.copyWith(themeMode: ThemeMode.system));
    }
  }
}
