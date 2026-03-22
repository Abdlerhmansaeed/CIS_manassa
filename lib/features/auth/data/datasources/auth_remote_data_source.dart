import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponse> login(String userCode, String password);
  Future<CredentialResponse> getCredentials({
    required String studentId,
    required String nationalNumber,
  });
}
