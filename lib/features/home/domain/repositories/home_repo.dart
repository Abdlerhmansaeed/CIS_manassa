import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quizezs_response.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/student_calander_events_response.dart';

abstract interface class HomeRepo {
  Future<ApiResult<StudentCalanderEventsResponse>> getStudentCalenderEvents();


  Future<ApiResult<QuizzesResponse>> getStudentQuizzes({required int courseId});
}
