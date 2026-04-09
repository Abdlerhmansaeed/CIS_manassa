import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quiz.dart';
import 'package:mansaa_app/features/home/domain/usecases/get_quiz_detailes_use_case.dart';
import 'package:mansaa_app/features/home/domain/usecases/get_student_running_events_use_case.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_state.dart';
import 'package:mansaa_app/features/home/presentation/mappers/home_events_mapper.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetStudentRunningEventsUseCase _studentRunningEventsUseCase;
  final GetQuizDetailsUseCase _getQuizDetails;
  
  HomeCubit(this._studentRunningEventsUseCase, this._getQuizDetails)
    : super(const HomeState());

  /// Fetches upcoming events and maps them to [HomeDisplayData] for the UI.
  Future<void> getStudentCalenderRunningEvents() async {
    emit(state.copyWith(studentRunningEventsState: AppStates.loading));

    final request = await _studentRunningEventsUseCase.call();

    request.when(
      onSuccess: (data) {
        final events = data.events ?? [];
        emit(
          state.copyWith(
            studentRunningEventsState: AppStates.success,
            studentRunningEventsResponse: data,
            // Use the mapper to build display-optimized data
            displayData: HomeEventsMapper.mapToDisplayData(events),
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            studentRunningEventsState: AppStates.failure,
            failure: failure,
          ),
        );
      },
    );
  }

  final Map<int, Quiz> _cachedQuizzes = {};
  
  /// Fetches full details for a specific quiz, with basic in-memory caching.
  Future<void> getQuizDetails({
    required int courseId,
    required int quizId,
    bool forceRefresh = false,
  }) async {
    emit(state.copyWith(quizDetailsState: AppStates.loading));
    
    if (!forceRefresh && _cachedQuizzes.containsKey(quizId)) {
      emit(
        state.copyWith(
          quizDetailsState: AppStates.success,
          quizDetails: _cachedQuizzes[quizId],
        ),
      );
      return;
    }

    final request = await _getQuizDetails.call(
      courseId: courseId,
      quizId: quizId,
    );

    request.when(
      onSuccess: (data) {
        _cachedQuizzes[quizId] = data;
        emit(
          state.copyWith(
            quizDetailsState: AppStates.success,
            quizDetails: data,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            quizDetailsState: AppStates.failure,
            failure: failure,
          ),
        );
      },
    );
  }

  /// Clears the local quiz cache.
  void clearQuizCache() {
    _cachedQuizzes.clear();
  }
}
