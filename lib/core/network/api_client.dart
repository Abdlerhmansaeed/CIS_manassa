import 'package:dio/dio.dart';
import 'package:mansaa_app/core/network/endpoints/app_endpoints.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';
import 'package:mansaa_app/features/auth/data/models/user_site_info_response/user_site_info_response.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quizezs_response.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/student_calander_events_response.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(AppEndPoints.loginStudentEndPoint)
  @FormUrlEncoded()
  Future<LoginResponse> login(
    @Field("username") String userCode,
    @Field("password") String password, {
    @Field("service") String service = "moodle_mobile_app",
  });

  @GET(AppEndPoints.moodleWebService)
  Future<UserSiteInfoResponse> getUserSiteInfo({
    @Query("wsfunction")
    String wsfunction = AppEndPoints.getUserSiteInfoEndPoint,
  });

  @GET(AppEndPoints.moodleWebService)
  Future<List<StudentCourseResponse>> getStudentEnrolledCourses(
    @Query("userid") int userId, {
    @Query("wsfunction")
    String wsfunction = AppEndPoints.getStudentEnrolledCoursesEndPoint,
  });

  @GET(AppEndPoints.moodleWebService)
  Future<List<SectionModel>> getCourseContents(
    @Query("courseid") int courseId, {
    @Query("wsfunction")
    String wsfunction = AppEndPoints.getCourseDetailsEndPoint,
  });
  @GET(AppEndPoints.moodleWebService)
  Future<StudentCalanderEventsResponse> getStudentCalenderEvents({
    @Query("wsfunction")
    String wsfunction = AppEndPoints.getUserCalenderEventsEndPoint,
  });

  @GET(AppEndPoints.moodleWebService)
  Future<QuizzesResponse> getStudentQuizzes(
    @Query("courseids[0]") int courseId, {
    @Query("wsfunction")
    String wsfunction = AppEndPoints.getUserQuizzesEndPoint,
  });
}
