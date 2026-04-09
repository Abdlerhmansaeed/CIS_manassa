import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/error_handling/error_handling.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/core/network/dio_exception_handler.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quizezs_response.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/student_calander_events_response.dart';
import 'package:mansaa_app/features/home/domain/repositories/home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _remoteDataSource;

  const HomeRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<StudentCalanderEventsResponse>> getStudentCalenderEvents() async {
    try {
      final response = await safeApiCall(
        () => _remoteDataSource.getStudentCalenderEvents(),
      );
      return ApiResult.success(response);
    } on AppException catch (e) {
      Logger.error('Get calendar events failed', e, null, 'HomeRepo');
      return ApiResult.failure(mapExceptionToFailure(e));
    }
  }

  @override
  Future<ApiResult<QuizzesResponse>> getStudentQuizzes({
    required int courseId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _remoteDataSource.getStudentQuizzes(courseId: courseId),
      );
      return ApiResult.success(response);
    } on AppException catch (e) {
      Logger.error('Get quizzes failed', e, null, 'HomeRepo');
      return ApiResult.failure(mapExceptionToFailure(e));
    }
  }
}
