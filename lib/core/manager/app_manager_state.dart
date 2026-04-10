import 'package:equatable/equatable.dart';

class AppManagerState extends Equatable {
  final bool isRememberMe;
  final String? userCode;
  final String? userPassword;
  final bool isLoggedIn;


  const AppManagerState({
    this.isRememberMe = false,
    this.userCode,
    this.userPassword,
    this.isLoggedIn = false,
  });

  @override
  List<Object?> get props => [isRememberMe, userCode, userPassword, isLoggedIn,];

  AppManagerState copyWith({
    bool? isRememberMe,
    String? userCode,
    String? userPassword,
    bool? isLoggedIn,
  }) {
    return AppManagerState(
      isRememberMe: isRememberMe ?? this.isRememberMe,
      userCode: userCode ?? this.userCode,
      userPassword: userPassword ?? this.userPassword,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
