import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';
import 'package:mansaa_app/features/auth/domain/repositories/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<ApiResult<LoginResponse>> call({
    required String userCode,
    required String password,
  }) async {
    return await _authRepo.login(userCode: userCode, password: password);
  }
}
