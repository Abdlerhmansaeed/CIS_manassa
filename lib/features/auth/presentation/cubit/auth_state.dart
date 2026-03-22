// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loginState = AppStates.initial,
    this.loginResponse,
    this.errorMessage,
    this.shouldRememberMe = false,
    this.credentialsState = AppStates.initial,
    this.credentialResponse,
  });

  final AppStates loginState;
  final LoginResponse? loginResponse;
  final String? errorMessage;
  final bool shouldRememberMe;
  final AppStates credentialsState;
  final CredentialResponse? credentialResponse;

  AuthState copyWith({
    AppStates? loginState,
    LoginResponse? loginResponse,
    String? errorMessage,
    bool? shouldRememberMe,
    AppStates? credentialsState,
    CredentialResponse? credentialResponse,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      loginResponse: loginResponse ?? this.loginResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      shouldRememberMe: shouldRememberMe ?? this.shouldRememberMe,
      credentialsState: credentialsState ?? this.credentialsState,
      credentialResponse: credentialResponse ?? this.credentialResponse,
    );
  }

  @override
  List<Object?> get props => [
        loginState,
        loginResponse,
        errorMessage,
        shouldRememberMe,
        credentialsState,
        credentialResponse,
      ];
}
