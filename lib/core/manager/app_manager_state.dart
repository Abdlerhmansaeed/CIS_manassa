import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppManagerState extends Equatable {
  final bool isRememberMe;
  final String? userCode;
  final String? userPassword;
  final bool isLoggedIn;
  final ThemeMode themeMode;

  const AppManagerState({
    this.isRememberMe = false,
    this.userCode,
    this.userPassword,
    this.isLoggedIn = false,
    this.themeMode = ThemeMode.light,
  });

  @override
  List<Object?> get props => [isRememberMe, userCode, userPassword, isLoggedIn, themeMode];

  AppManagerState copyWith({
    bool? isRememberMe,
    String? userCode,
    String? userPassword,
    bool? isLoggedIn,
    ThemeMode? themeMode,
  }) {
    return AppManagerState(
      isRememberMe: isRememberMe ?? this.isRememberMe,
      userCode: userCode ?? this.userCode,
      userPassword: userPassword ?? this.userPassword,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
