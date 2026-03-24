import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_client.dart';
import 'package:mansaa_app/core/network/cis_api_client.dart';
import 'package:mansaa_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';
import 'package:mansaa_app/features/auth/data/models/user_site_info_response/user_site_info_response.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final CisApiClient _cisApiClient;

  AuthRemoteDataSourceImpl(this._apiClient, this._cisApiClient);

  @override
  Future<LoginResponse> login(String userCode, String password) {
    return _apiClient.login(userCode, password);
  }

  @override
  Future<CredentialResponse> getCredentials({
    required String studentId,
    required String nationalNumber,
  }) async {
    final html = await _cisApiClient.getCredentials(
      studentId: studentId,
      nationalNumber: nationalNumber,
    );
    return CredentialResponse.fromHtml(html);
  }

  @override
  Future<UserSiteInfoResponse> getUserSiteInfo() {
    return _apiClient.getUserSiteInfo();
  }
}
