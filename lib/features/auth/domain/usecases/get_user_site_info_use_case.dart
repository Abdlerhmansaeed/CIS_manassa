import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/auth/data/models/user_site_info_response/user_site_info_response.dart';
import 'package:mansaa_app/features/auth/domain/repositories/auth_repo.dart';

@injectable
class GetUserSiteInfoUseCase {
  final AuthRepo _repository;

  GetUserSiteInfoUseCase(this._repository);

  Future<ApiResult<UserSiteInfoResponse>> call() {
    return _repository.getUserSiteInfo();
  }
}
