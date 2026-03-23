import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/network/session/user_session.dart';
import 'package:mansaa_app/features/my_courses/domain/usecases/get_course_content_use_case.dart';
import 'package:mansaa_app/features/my_courses/domain/usecases/get_enrolled_courses_use_case.dart';
import 'package:mansaa_app/features/my_courses/presentation/cubit/courses_state.dart';

@injectable
class CoursesCubit extends Cubit<CoursesState> {
  final GetEnrolledCoursesUseCase _getEnrolledCoursesUseCase;
  final UserSession _userSession;
  final GetCourseContentUseCase _getCourseContentUseCase;

  CoursesCubit(
    this._getEnrolledCoursesUseCase,
    this._userSession,
    this._getCourseContentUseCase,
  ) : super(const CoursesState());

  /// First load — uses cache if available.
  Future<void> loadCourses() async {
    emit(state.copyWith(coursesState: AppStates.loading));
    await _fetchCourses(forceRefresh: false);
  }

  /// Pull-to-refresh — always hits the API.
  Future<void> refreshCourses() async {
    emit(state.copyWith(isRefreshing: true));
    await _fetchCourses(forceRefresh: true);
  }

  Future<void> _fetchCourses({required bool forceRefresh}) async {
    final token = _userSession.getToken();
    log(token ?? 'Token is Null');
    final userDataRaw = _userSession.getUserId();
    log(userDataRaw.toString());

    if (token == null || userDataRaw == null) {
      emit(
        state.copyWith(
          coursesState: AppStates.failure,
          errorMessage: 'Session expired — please log in again',
          isRefreshing: false,
        ),
      );
      return;
    }

    final userId = int.tryParse(userDataRaw.toString());
    if (userId == null) {
      emit(
        state.copyWith(
          coursesState: AppStates.failure,
          errorMessage: 'Invalid user data — please log in again',
          isRefreshing: false,
        ),
      );
      return;
    }

    final result = await _getEnrolledCoursesUseCase.call(
      forceRefresh: forceRefresh,
    );

    result.when(
      onSuccess: (courses) {
        emit(
          state.copyWith(
            coursesState: AppStates.success,
            courses: courses,
            isRefreshing: false,
          ),
        );
      },
      onFailure: (error) {
        emit(
          state.copyWith(
            coursesState: AppStates.failure,
            errorMessage: error,
            isRefreshing: false,
          ),
        );
      },
    );
  }

  Future<void> getCourseDetails({required int courseId}) async {
    emit(state.copyWith(courseContentsState: AppStates.loading));
    final result = await _getCourseContentUseCase.call(courseId);
    result.when(
      onSuccess: (courseContents) {
        log(courseContents.toString());

        final courseContentsWithoutEmptySections = courseContents
            .where((element) => element.modules.isNotEmpty)
            .toList();
        emit(
          state.copyWith(
            courseContentsState: AppStates.success,
            courseContents: courseContentsWithoutEmptySections,
          ),
        );
      },
      onFailure: (error) {
        emit(
          state.copyWith(
            courseContentsState: AppStates.failure,
            errorMessage: error,
          ),
        );
      },
    );
  }
}
