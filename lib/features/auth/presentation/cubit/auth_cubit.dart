import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/auth/domain/usecases/get_credentials_use_case.dart';
import 'package:mansaa_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase, this._getCredentialsUseCase)
      : super(const AuthState());

  final LoginUseCase _loginUseCase;
  final GetCredentialsUseCase _getCredentialsUseCase;

  Future<void> loginStudent({
    required String studentCode,
    required String studentPassword,
  }) async {
    emit(state.copyWith(loginState: AppStates.loading));

    final loginResult = await _loginUseCase.call(
      userCode: studentCode,
      password: studentPassword,
    );

    loginResult.when(
      onSuccess: (data) {
        emit(state.copyWith(loginResponse: data, loginState: AppStates.success));
      },
      onFailure: (error) {
        emit(state.copyWith(loginState: AppStates.failure, errorMessage: error));
      },
    );
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
        emit(state.copyWith(
          credentialResponse: data,
          credentialsState: AppStates.success,
        ));
      },
      onFailure: (error) {
        emit(state.copyWith(
          credentialsState: AppStates.failure,
          errorMessage: error,
        ));
      },
    );
  }

  void toggleRememberMe({required bool shouldRememberMe}) {
    emit(state.copyWith(shouldRememberMe: shouldRememberMe));
  }
}
