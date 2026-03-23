import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';

abstract interface class CoursesRepository {
  Future<ApiResult<List<StudentCourseResponse>>> getEnrolledCourses({
    bool forceRefresh = false,
  });

  Future<ApiResult<List<SectionModel>>> getCourseContents(int courseId);
}
