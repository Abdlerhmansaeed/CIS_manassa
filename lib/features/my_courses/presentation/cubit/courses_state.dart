import 'package:equatable/equatable.dart';
import 'package:mansaa_app/core/error_handling/failures/failure.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';

class CoursesState extends Equatable {
  const CoursesState({
    this.coursesState = AppStates.initial,
    this.courses = const [],
    this.failure,
    this.isRefreshing = false,
    this.courseContents = const [],
    this.courseContentsState = AppStates.initial,
  });

  final AppStates coursesState;
  final List<StudentCourseResponse> courses;
  final Failure? failure;
  final bool isRefreshing;
  final List<SectionModel> courseContents;
  final AppStates courseContentsState;

  CoursesState copyWith({
    AppStates? coursesState,
    List<StudentCourseResponse>? courses,
    Failure? failure,
    bool? isRefreshing,
    List<SectionModel>? courseContents,
    AppStates? courseContentsState,
  }) {
    return CoursesState(
      coursesState: coursesState ?? this.coursesState,
      courses: courses ?? this.courses,
      failure: failure ?? this.failure,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      courseContents: courseContents ?? this.courseContents,
      courseContentsState: courseContentsState ?? this.courseContentsState,
    );
  }

  @override
  List<Object?> get props => [
    coursesState,
    courses,
    failure,
    courseContents,
    courseContentsState,
    isRefreshing,
  ];
}
