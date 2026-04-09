import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/error_handling/error_handling.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/core/network/dio_exception_handler.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';
import 'package:mansaa_app/features/auth/data/models/user_site_info_response/user_site_info_response.dart';
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
      final result = await safeApiCall(
        () => _remoteDataSource.login(userCode, password),
      );

      // If we reach here, MoodleErrorInterceptor didn't find an errorbody.
      // We check for token presence just in case.
      if (result.token != null) return ApiResult.success(result);

      return ApiResult.failure(
        const ServerFailure(AppErrorCode.unknownServerError),
      );
    } on AppException catch (e) {
      Logger.error('Login failed', e, null, 'AuthRepo');
      return ApiResult.failure(mapExceptionToFailure(e));
    }
  }

  @override
  Future<ApiResult<CredentialResponse>> getCredentials({
    required String studentId,
    required String nationalNumber,
  }) async {
    try {
      final result = await safeApiCall(
        () => _remoteDataSource.getCredentials(
          studentId: studentId,
          nationalNumber: nationalNumber,
        ),
      );
      return ApiResult.success(result);
    } on FormatException catch (e) {
      if (e.message == 'invalid_credentials') {
        Logger.info("Get credentials failed Because invalid credentials");
        return ApiResult.failure(
          const ServerFailure(AppErrorCode.invalidCredentialsForUserGetAccess),
        );
      }
      Logger.error('Credential parse error', e, null, 'AuthRepo');
      return ApiResult.failure(const ParseFailure(AppErrorCode.parseError));
    } on AppException catch (e) {
      if (e.technicalMessage == 'invalid_credentials') {
        Logger.error("Get credentials failed Because invalid credentials");
        return ApiResult.failure(
          const ServerFailure(AppErrorCode.invalidCredentialsForUserGetAccess),
        );
      }
      Logger.error('Get credentials failed', e, null, 'AuthRepo');
      // Logger.info(e.toString());
      return ApiResult.failure(mapExceptionToFailure(e));
    }
  }

  @override
  Future<ApiResult<UserSiteInfoResponse>> getUserSiteInfo() async {
    try {
      final result = await safeApiCall(
        () => _remoteDataSource.getUserSiteInfo(),
      );
      return ApiResult.success(result);
    } on AppException catch (e) {
      Logger.error('Get site info failed', e, null, 'AuthRepo');
      return ApiResult.failure(mapExceptionToFailure(e));
    }
  }
}
