// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String?,
      privatetoken: json['privatetoken'] as String?,
      error: json['error'] as String?,
      errorcode: json['errorcode'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'privatetoken': instance.privatetoken,
      'error': instance.error,
      'errorcode': instance.errorcode,
    };
