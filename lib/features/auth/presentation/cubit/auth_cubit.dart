import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/constants/app_keys.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client.dart';
import 'package:mansaa_app/features/auth/domain/usecases/get_credentials_use_case.dart';
import 'package:mansaa_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_state.dart';

import 'package:mansaa_app/core/network/session/user_session.dart';
import 'package:mansaa_app/features/auth/domain/usecases/get_user_site_info_use_case.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._loginUseCase,
    this._getCredentialsUseCase,
    this._getUserSiteInfoUseCase,
    this._storageClient,
    this._userSession,
  ) : super(const AuthState());

  final LoginUseCase _loginUseCase;
  final GetCredentialsUseCase _getCredentialsUseCase;
  final GetUserSiteInfoUseCase _getUserSiteInfoUseCase;
  final LocalStorageClient _storageClient;
  final UserSession _userSession;

  Future<void> loginStudent({
    required String studentCode,
    required String studentPassword,
  }) async {
    emit(state.copyWith(loginState: AppStates.loading));

    final loginResult = await _loginUseCase.call(
      userCode: studentCode,
      password: studentPassword,
    );

    await loginResult.when(
      onSuccess: (data) async {
        // Save credentials for remember me logic
        await Future.wait([
          _storageClient.saveSecureData(
            key: AppKeys.userCode,
            value: studentCode,
          ),
          _storageClient.saveSecureData(
            key: AppKeys.userPassword,
            value: studentPassword,
          ),
        ]);

        // Temporarily set token to fetch site info
        _userSession.setToken(data.token ?? "");

        log("User token is ${data.token}");

        final siteInfoResult = await _getUserSiteInfoUseCase.call();

        await siteInfoResult.when(
          onSuccess: (siteInfo) async {
            if (siteInfo.userid != null) {
              await _userSession.saveSession(
                token: data.token ?? "",
                userId: siteInfo.userid ?? 0,
              );

              emit(
                state.copyWith(
                  loginResponse: data,
                  loginState: AppStates.success,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  loginState: AppStates.failure,
                  errorMessage: "Could not retrieve user ID",
                ),
              );
            }
          },
          onFailure: (error) {
            emit(
              state.copyWith(
                loginState: AppStates.failure,
                errorMessage: error,
              ),
            );
          },
        );
      },
      onFailure: (error) {
        emit(
          state.copyWith(loginState: AppStates.failure, errorMessage: error),
        );
      },
    );
  }

  Future<void> logout() async {
    await _userSession.clearSession();
    // Navigation to login should be handled by UI or AppManager
  }

  Future<void> getCredentials({
    required String studentId,
    required String nationalNumber,
  }) async {
    emit(state.copyWith(credentialsState: AppStates.loading));

    final result = await _getCredentialsUseCase.call(
      studentId: studentId,
      nationalNumber: nationalNumber,
    );

    result.when(
      onSuccess: (data) {
        emit(
          state.copyWith(
            credentialResponse: data,
            credentialsState: AppStates.success,
          ),
        );
      },
      onFailure: (error) {
        emit(
          state.copyWith(
            credentialsState: AppStates.failure,
            errorMessage: error,
          ),
        );
      },
    );
  }

  void updateGetAccessForCredentialsStep({required int currentStep}) {
    emit(state.copyWith(getAccessForCredentialsStep: currentStep));
  }

  void toggleRememberMe({required bool shouldRememberMe}) {
    _storageClient.saveData(
      key: AppKeys.rememberMe,
      value: shouldRememberMe.toString(),
    );
    emit(state.copyWith(shouldRememberMe: shouldRememberMe));
  }

  // Future<void> get
}
