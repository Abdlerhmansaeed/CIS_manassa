import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/error_handling/error_handling.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/core/network/dio_exception_handler.dart';
import 'package:mansaa_app/features/my_courses/data/datasources/courses_local_data_source.dart';
import 'package:mansaa_app/features/my_courses/data/datasources/courses_remote_data_source.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';
import 'package:mansaa_app/features/my_courses/domain/repositories/courses_repository.dart';

@Injectable(as: CoursesRepository)
class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource _remoteDataSource;
  final CoursesLocalDataSource _localDataSource;
  final CoursesLocalDataSource _localDataSourceNow;

  CoursesRepositoryImpl(
    this._remoteDataSource,
    @Named("oldCoursesLocalDataSource") this._localDataSource,
    @Named("newCoursesLocalDataSource") this._localDataSourceNow,
  );

  @override
  Future<ApiResult<List<StudentCourseResponse>>> getEnrolledCourses({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && await _localDataSource.isCacheValid()) {
      final cached = await _localDataSourceNow.getCachedCourses();
      if (cached != null) {
        Logger.debug('Returning cached courses (${cached.length} items)');
        return ApiResult.success(cached);
      }
    }

    try {
      final courses = await safeApiCall(
        () => _remoteDataSource.getEnrolledCourses(),
      );
      await _localDataSourceNow.cacheCourses(courses);
      return ApiResult.success(courses);
    } on AppException catch (e) {
      Logger.error('Failed to fetch courses from API', e, null, 'CoursesRepo');
      return _fallbackToCache(e);
    }
  }

  Future<ApiResult<List<StudentCourseResponse>>> _fallbackToCache(
    AppException error,
  ) async {
    final stale = await _localDataSource.getCachedCourses();
    if (stale != null && stale.isNotEmpty) {
      Logger.warning(
        'API failed — returning stale cache (${stale.length} items)',
      );
      return ApiResult.success(stale);
    }
    return ApiResult.failure(mapExceptionToFailure(error));
  }

  @override
  Future<ApiResult<List<SectionModel>>> getCourseContents(int courseId) async {
    try {
      final contents = await safeApiCall(
        () => _remoteDataSource.getCourseContents(courseId),
      );
      return ApiResult.success(contents);
    } on AppException catch (e) {
      Logger.error('Failed to fetch course contents', e, null, 'CoursesRepo');
      return ApiResult.failure(mapExceptionToFailure(e));
    }
  }
}
