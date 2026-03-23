import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';

abstract interface class CoursesRemoteDataSource {
  Future<List<StudentCourseResponse>> getEnrolledCourses();
  Future<List<SectionModel>> getCourseContents(int courseId);
}
