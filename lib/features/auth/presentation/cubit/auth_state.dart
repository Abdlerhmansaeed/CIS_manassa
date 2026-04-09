import 'package:equatable/equatable.dart';
import 'package:mansaa_app/core/error_handling/failures/failure.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loginState = AppStates.initial,
    this.loginResponse,
    this.failure,
    this.shouldRememberMe = false,
    this.credentialsState = AppStates.initial,
    this.credentialResponse,
    this.getAccessForCredentialsStep = 0,
  });

  final AppStates loginState;
  final LoginResponse? loginResponse;
  final Failure? failure;
  final bool shouldRememberMe;
  final AppStates credentialsState;
  final CredentialResponse? credentialResponse;
  final int getAccessForCredentialsStep;

  AuthState copyWith({
    AppStates? loginState,
    LoginResponse? loginResponse,
    Failure? failure,
    bool? shouldRememberMe,
    AppStates? credentialsState,
    CredentialResponse? credentialResponse,
    int? getAccessForCredentialsStep,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      loginResponse: loginResponse ?? this.loginResponse,
      failure: failure ?? this.failure,
      shouldRememberMe: shouldRememberMe ?? this.shouldRememberMe,
      credentialsState: credentialsState ?? this.credentialsState,
      credentialResponse: credentialResponse ?? this.credentialResponse,
      getAccessForCredentialsStep:
          getAccessForCredentialsStep ?? this.getAccessForCredentialsStep,
    );
  }

  @override
  List<Object?> get props => [
    loginState,
    loginResponse,
    failure,
    shouldRememberMe,
    credentialsState,
    credentialResponse,
    getAccessForCredentialsStep,
  ];
}
