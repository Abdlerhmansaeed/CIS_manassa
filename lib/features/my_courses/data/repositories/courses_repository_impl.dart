import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/my_courses/data/datasources/courses_local_data_source.dart';
import 'package:mansaa_app/features/my_courses/data/datasources/courses_remote_data_source.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';
import 'package:mansaa_app/features/my_courses/domain/repositories/courses_repository.dart';

@Injectable(as: CoursesRepository)
class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource _remoteDataSource;
  final CoursesLocalDataSource _localDataSource;

  CoursesRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<ApiResult<List<StudentCourseResponse>>> getEnrolledCourses({
    bool forceRefresh = false,
  }) async {
    // Return valid cache when no forced refresh is requested
    if (!forceRefresh && await _localDataSource.isCacheValid()) {
      final cached = await _localDataSource.getCachedCourses();
      if (cached != null) {
        Logger.debug('Returning cached courses (${cached.length} items)');
        return ApiResult.success(cached);
      }
    }

    // Fetch from API
    try {
      final courses = await _remoteDataSource.getEnrolledCourses();
      await _localDataSource.cacheCourses(courses);
      return ApiResult.success(courses);
    } catch (e) {
      Logger.error('Failed to fetch courses from API: $e');
      return _fallbackToCache(e);
    }
  }

  /// Returns stale cache on API failure, or a failure result if no cache.
  Future<ApiResult<List<StudentCourseResponse>>> _fallbackToCache(
    Object error,
  ) async {
    final stale = await _localDataSource.getCachedCourses();
    if (stale != null && stale.isNotEmpty) {
      Logger.warning(
        'API failed — returning stale cache (${stale.length} items)',
      );
      return ApiResult.success(stale);
    }
    return ApiResult.failure(error.toString());
  }

  @override
  Future<ApiResult<List<SectionModel>>> getCourseContents(int courseId) async {
    try {
      final contents = await _remoteDataSource.getCourseContents(courseId);
      return ApiResult.success(contents);
    } catch (e) {
      Logger.error('Failed to fetch course contents from API: $e');
      return ApiResult.failure(e.toString());
    }
  }
}
