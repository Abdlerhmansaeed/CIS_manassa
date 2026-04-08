import 'package:mansaa_app/features/home/data/models/quizezs_response/quizezs_response.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/student_calander_events_response.dart';

abstract interface class HomeRemoteDataSource {
  Future<StudentCalanderEventsResponse> getStudentCalenderEvents();

  Future<QuizzesResponse> getStudentQuizzes({required int courseId});
}
