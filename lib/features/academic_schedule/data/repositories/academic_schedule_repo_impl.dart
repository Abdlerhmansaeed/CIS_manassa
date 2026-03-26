import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
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

  AcademicScheduleRepoImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

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

      final response = await _remoteDataSource.getAcademicSchedule(
        studentCode: studentCode,
        studentNationalId: studentNationalId,
      );

      // Cache the new schedule
      await _localDataSource.saveSchedule(
        CachedScheduleModel(
          scheduleItems: response,
          cachedAt: DateTime.now(),
        ),
      );

      return ApiResult.success(response);
    } catch (e) {
      // If remote fails, try to return expired cache as fallback
      final cached = await _localDataSource.getSchedule();
      if (cached != null) {
        return ApiResult.success(cached.scheduleItems);
      }
      return ApiResult.failure(e.toString());
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
