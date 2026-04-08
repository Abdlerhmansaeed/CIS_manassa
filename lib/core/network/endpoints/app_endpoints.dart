// ignore: file_names
class AppEndPoints {
  static const String cisMoodleBaseUrl = 'https://lmscis.com/';
  static const String loginStudentEndPoint = 'login/token.php';

  static const String cisServicesBaseUrl = 'https://services.cis.edu.eg/';
  static const String credentialsEndPoint = 'Student_Tmz_Pass/Search2';
  static const String moodleWebService = 'webservice/rest/server.php';
  static const String getUserSiteInfoEndPoint = "core_webservice_get_site_info";
  static const String getStudentEnrolledCoursesEndPoint =
      "core_enrol_get_users_courses";
  static const String getCourseDetailsEndPoint = "core_course_get_contents";

  static const String getAcademicScheduleEndPoint = "Students_sec_lec/Search";
  static const String getUserCalenderEventsEndPoint =
      "core_calendar_get_action_events_by_timesort";

  static const String getUserQuizzesEndPoint = "mod_quiz_get_quizzes_by_courses";
}
