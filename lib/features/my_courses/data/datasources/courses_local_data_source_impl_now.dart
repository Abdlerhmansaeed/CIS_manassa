import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/constants/app_keys.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/core/local_storage/hive_client.dart';
import 'package:mansaa_app/features/my_courses/data/datasources/courses_local_data_source.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';

@Named("newCoursesLocalDataSource")
@Injectable(as: CoursesLocalDataSource)
class CoursesLocalDataSourceImplNow implements CoursesLocalDataSource {
  final HiveClient _localHiveClient;
  CoursesLocalDataSourceImplNow(this._localHiveClient);
  @override
  Future<void> cacheCourses(List<StudentCourseResponse> courses) async {
    try {
      final coursesBox = await _localHiveClient.openBox(AppKeys.coursesBox);
      Logger.info("courses: ${courses.runtimeType}");
      await coursesBox.put(AppKeys.cachedCourses, courses);
      Logger.info("courses cached successfully ${courses.length} courses");
    } catch (error, stackTrace) {
      Logger.error(error.toString(), error, stackTrace);
    }
  }

  @override
  Future<List<StudentCourseResponse>?> getCachedCourses() async {
    try {
      Logger.info("getCachedCourses");
      final coursesBox = await _localHiveClient.openBox(AppKeys.coursesBox);

      final rawCourses = await coursesBox.get(AppKeys.cachedCourses);
      
      if (rawCourses == null) return null;

      final cachedCourses = List<StudentCourseResponse>.from(rawCourses);

      Logger.info("chachedCourses: ${cachedCourses.runtimeType}");

      return cachedCourses;
    } catch (error, stackTrace) {
      Logger.error(error.toString(), error, stackTrace);
      return null;
    }
  }

  @override
  Future<bool> isCacheValid() async {
    try {
      final coursesBox = await _localHiveClient.openBox(AppKeys.coursesBox);
      final cachedCourses = coursesBox.get(AppKeys.cachedCourses);
      return cachedCourses != null;
    } catch (error) {
      Logger.error(error.toString());
      return false;
    }
  }
}
