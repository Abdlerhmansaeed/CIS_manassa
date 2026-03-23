import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';
import 'package:mansaa_app/features/my_courses/domain/repositories/courses_repository.dart';

@injectable
class GetCourseContentUseCase {
  final CoursesRepository _coursesRepository;

  GetCourseContentUseCase(this._coursesRepository);

  Future<ApiResult<List<SectionModel>>> call(int courseId) async {
    return await _coursesRepository.getCourseContents(courseId);
  }
}
