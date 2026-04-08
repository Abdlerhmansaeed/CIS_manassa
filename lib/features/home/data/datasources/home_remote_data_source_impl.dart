import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_client.dart';
import 'package:mansaa_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quizezs_response.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/student_calander_events_response.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient _apiClient;
  HomeRemoteDataSourceImpl(this._apiClient);
  @override
  Future<StudentCalanderEventsResponse> getStudentCalenderEvents() {
    return _apiClient.getStudentCalenderEvents();
  }

  @override
  Future<QuizzesResponse> getStudentQuizzes({required int courseId}) {
    return _apiClient.getStudentQuizzes(courseId);
  }
}
