import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/error_handling/error_handling.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/core/network/dio_exception_handler.dart';
import 'package:mansaa_app/features/academic_schedule/data/datasources/academic_schedule_local_data_source.dart';
import 'package:mansaa_app/features/academic_schedule/data/datasources/academic_schedule_remote_data_source.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/cached_schedule_model.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/student_credentials_model.dart';
import 'package:mansaa_app/features/academic_schedule/domain/repositories/academic_schedule_repo.dart';

@Injectable(as: AcademicScheduleRepo)
class AcademicScheduleRepoImpl implements AcademicScheduleRepo {
  final AcademicScheduleRemoteDataSource _remoteDataSource;
  final AcademicScheduleLocalDataSource _localDataSource;

  AcademicScheduleRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<ApiResult<List<ScheduleItemModel>>> getAcademicSchedule({
    String? studentCode,
    required String studentNationalId,
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cached = await _localDataSource.getSchedule();
        if (cached != null && !cached.isExpired) {
          return ApiResult.success(cached.scheduleItems);
        }
      }

      final response = await safeApiCall(
        () => _remoteDataSource.getAcademicSchedule(
          studentCode: studentCode,
          studentNationalId: studentNationalId,
        ),
      );

      await _localDataSource.saveSchedule(
        CachedScheduleModel(scheduleItems: response, cachedAt: DateTime.now()),
      );

      return ApiResult.success(response);
    } on AppException catch (e) {
      Logger.error('Get schedule failed', e, null, 'ScheduleRepo');
      // عند فشل الشبكة، نُرجع الكاش المنتهي إن وُجد
      final cached = await _localDataSource.getSchedule();
      if (cached != null) return ApiResult.success(cached.scheduleItems);
      return ApiResult.failure(mapExceptionToFailure(e));
    }
  }

  @override
  Future<void> saveCredentials(StudentCredentialsModel credentials) async {
    await _localDataSource.saveCredentials(credentials);
  }

  @override
  Future<StudentCredentialsModel?> getCredentials() async {
    return await _localDataSource.getCredentials();
  }
}
