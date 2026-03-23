import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/domain/repositories/courses_repository.dart';

@injectable
class GetEnrolledCoursesUseCase {
  final CoursesRepository _repository;

  GetEnrolledCoursesUseCase(this._repository);

  Future<ApiResult<List<StudentCourseResponse>>> call({
    bool forceRefresh = false,
  }) {
    return _repository.getEnrolledCourses(forceRefresh: forceRefresh);
  }
}
