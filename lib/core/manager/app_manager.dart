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
    await _userSession.init();

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
}
