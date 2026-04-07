import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quizezs_response.dart';
// import 'package:mansaa_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/student_calander_events_response.dart';
import 'package:mansaa_app/features/home/domain/repositories/home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _remoteDataSource;

  const HomeRepoImpl(this._remoteDataSource);
  @override
  Future<ApiResult<StudentCalanderEventsResponse>>
  getStudentCalenderEvents() async {
    try {
      final response = await _remoteDataSource.getStudentCalenderEvents();
      return ApiResult.success(response);
    } catch (e) {
      //todo: handle error with Error Handler Class
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<QuizzesResponse>> getStudentQuizzes({
    required int courseId,
  }) async {
    try {
      final response = await _remoteDataSource.getStudentQuizzes(
        courseId: courseId,
      );
      return ApiResult.success(response);
    } catch (e) {
      //todo: handle error with Error Handler Class
      return ApiResult.failure(e.toString());
    }
  }
}
