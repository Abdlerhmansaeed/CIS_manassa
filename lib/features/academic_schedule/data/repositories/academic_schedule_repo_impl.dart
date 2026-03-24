import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/academic_schedule/data/datasources/academic_schedule_remote_data_source.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';
import 'package:mansaa_app/features/academic_schedule/domain/repositories/academic_schedule_repo.dart';

@Injectable(as: AcademicScheduleRepo)
class AcademicScheduleRepoImpl implements AcademicScheduleRepo {
  final AcademicScheduleRemoteDataSource _remoteDataSource;
  // final NetworkInfo _networkInfo;

  AcademicScheduleRepoImpl(
    this._remoteDataSource,
    // this._networkInfo,
  );

  @override
  Future<ApiResult<List<ScheduleItemModel>>> getAcademicSchedule({
    String? studentCode,
    required String studentNationalId,
  }) async {
    try {
      final response = await _remoteDataSource.getAcademicSchedule(
        studentCode: studentCode,
        studentNationalId: studentNationalId,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
