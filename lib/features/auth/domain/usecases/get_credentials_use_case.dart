import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/domain/repositories/auth_repo.dart';

@injectable
class GetCredentialsUseCase {
  final AuthRepo _authRepo;

  GetCredentialsUseCase(this._authRepo);

  Future<ApiResult<CredentialResponse>> call({
    required String studentId,
    required String nationalNumber,
  }) {
    return _authRepo.getCredentials(
      studentId: studentId,
      nationalNumber: nationalNumber,
    );
  }
}
