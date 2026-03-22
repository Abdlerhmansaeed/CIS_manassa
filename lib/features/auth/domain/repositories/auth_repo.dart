import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';

abstract interface class AuthRepo {
  Future<ApiResult<LoginResponse>> login({
    required String userCode,
    required String password,
  });

  Future<ApiResult<CredentialResponse>> getCredentials({
    required String studentId,
    required String nationalNumber,
  });
}
