import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends Equatable {
  final String? token;
  final String? privatetoken;
  final String? error;
  final String? errorcode;

  const LoginResponse({
    this.token,
    this.privatetoken,
    this.error,
    this.errorcode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  LoginResponse copyWith({
    String? token,
    String? privatetoken,
    String? error,
    String? errorcode,
  }) {
    return LoginResponse(
      token: token ?? this.token,
      privatetoken: privatetoken ?? this.privatetoken,
      error: error ?? this.error,
      errorcode: errorcode ?? this.errorcode,
    );
  }

  @override
  List<Object?> get props => [token, privatetoken, error, errorcode];
}
