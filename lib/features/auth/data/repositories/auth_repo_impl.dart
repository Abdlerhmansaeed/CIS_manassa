import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';
import 'package:mansaa_app/features/auth/domain/repositories/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<LoginResponse>> login({
    required String userCode,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(userCode, password);
      if (result.token != null) {
        return ApiResult.success(result);
      } else {
        return ApiResult.failure(result.error ?? 'Invalid login credentials');
      }
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<CredentialResponse>> getCredentials({
    required String studentId,
    required String nationalNumber,
  }) async {
    try {
      final result = await _remoteDataSource.getCredentials(
        studentId: studentId,
        nationalNumber: nationalNumber,
      );
      return ApiResult.success(result);
    } on FormatException catch (e) {
      return ApiResult.failure(e.message);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
