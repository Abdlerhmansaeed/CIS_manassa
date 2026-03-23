import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/constants/app_keys.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client.dart';
import 'package:mansaa_app/core/manager/app_manager_state.dart';
import 'package:mansaa_app/core/network/session/user_session.dart';

@singleton
class AppManager extends Cubit<AppManagerState> {
  AppManager(this._storageClient, this._userSession) : super(const AppManagerState());

  final LocalStorageClient _storageClient;
  final UserSession _userSession;

  Future<void> checkRememberMe() async {
    await _userSession.init();

    final isRememberMe = await _storageClient.getData(key: AppKeys.rememberMe);
    final userCode = await _storageClient.getSecureData(key: AppKeys.userCode);
    final userPassword = await _storageClient.getSecureData(
      key: AppKeys.userPassword,
    );

    emit(
      state.copyWith(
        isRememberMe: isRememberMe == 'true',
        userCode: userCode,
        userPassword: userPassword,
        isLoggedIn: _userSession.isLoggedIn,
      ),
    );
  }
}
