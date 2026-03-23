import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';

abstract interface class CoursesLocalDataSource {
  Future<void> cacheCourses(List<StudentCourseResponse> courses);
  Future<List<StudentCourseResponse>?> getCachedCourses();
  Future<bool> isCacheValid();
}
