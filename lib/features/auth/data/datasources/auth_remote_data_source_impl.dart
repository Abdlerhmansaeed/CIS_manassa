import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_client.dart';
import 'package:mansaa_app/core/network/endpoints/app_endpoints.dart';
import 'package:mansaa_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._apiClient, this._dio);

  @override
  Future<LoginResponse> login(String userCode, String password) {
    return _apiClient.login(userCode, password);
  }

  @override
  Future<CredentialResponse> getCredentials({
    required String studentId,
    required String nationalNumber,
  }) async {
    final response = await _dio.get<String>(
      '${AppEndPoints.cisServicesBaseUrl}${AppEndPoints.credentialsEndPoint}',
      queryParameters: {
        'student_id': studentId,
        'national_number': nationalNumber,
      },
      options: Options(responseType: ResponseType.plain),
    );
    final html = response.data ?? '';
    return CredentialResponse.fromHtml(html);
  }
}