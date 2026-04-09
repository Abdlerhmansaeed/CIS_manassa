import 'package:equatable/equatable.dart';
import 'package:mansaa_app/core/error_handling/failures/failure.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quiz.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/student_calander_events_response.dart';
import 'home_display_data.dart';

class HomeState extends Equatable {
  final AppStates studentRunningEventsState;
  final StudentCalanderEventsResponse? studentRunningEventsResponse;
  final HomeDisplayData? displayData;
  final Failure? failure;
  final AppStates quizDetailsState;
  final Quiz? quizDetails;

  const HomeState({
    this.studentRunningEventsState = AppStates.initial,
    this.studentRunningEventsResponse,
    this.displayData,
    this.failure,
    this.quizDetailsState = AppStates.initial,
    this.quizDetails,
  });

  HomeState copyWith({
    AppStates? studentRunningEventsState,
    StudentCalanderEventsResponse? studentRunningEventsResponse,
    HomeDisplayData? displayData,
    Failure? failure,
    AppStates? quizDetailsState,
    Quiz? quizDetails,
  }) {
    return HomeState(
      studentRunningEventsState:
          studentRunningEventsState ?? this.studentRunningEventsState,
      studentRunningEventsResponse:
          studentRunningEventsResponse ?? this.studentRunningEventsResponse,
      displayData: displayData ?? this.displayData,
      failure: failure ?? this.failure,
      quizDetailsState: quizDetailsState ?? this.quizDetailsState,
      quizDetails: quizDetails ?? this.quizDetails,
    );
  }

  @override
  List<Object?> get props => [
    studentRunningEventsState,
    studentRunningEventsResponse,
    displayData,
    failure,
    quizDetailsState,
    quizDetails,
  ];
}
