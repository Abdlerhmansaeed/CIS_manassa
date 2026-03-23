import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_client.dart';
import 'package:mansaa_app/core/network/session/user_session.dart';
import 'package:mansaa_app/features/my_courses/data/datasources/courses_remote_data_source.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';

@Injectable(as: CoursesRemoteDataSource)
class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final ApiClient _apiClient;
  final UserSession _userSession;

  CoursesRemoteDataSourceImpl(this._apiClient, this._userSession);

  @override
  Future<List<StudentCourseResponse>> getEnrolledCourses() async {
    final userId = _userSession.getUserId();
    if (userId == null) {
      throw Exception('User ID not found in session');
    }
    return _apiClient.getStudentEnrolledCourses(userId);
  }

  @override
  Future<List<SectionModel>> getCourseContents(int courseId) {
    return _apiClient.getCourseContents(courseId);
  }
}
