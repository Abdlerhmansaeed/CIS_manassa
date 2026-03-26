import 'dart:developer';

import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
// import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/cubit/academic_schedule_state.dart';

// part 'academic_schedule_state.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/student_credentials_model.dart';
import 'package:mansaa_app/features/academic_schedule/domain/usecases/get_acadmic_schedule_use_case.dart';
import 'package:mansaa_app/features/academic_schedule/domain/usecases/get_student_credentials_use_case.dart';
import 'package:mansaa_app/features/academic_schedule/domain/usecases/save_student_credentials_use_case.dart';

@injectable
class AcademicScheduleCubit extends Cubit<AcademicScheduleState> {
  AcademicScheduleCubit(
    this._getAcademicScheduleUseCase,
    this._saveStudentCredentialsUseCase,
    this._getStudentCredentialsUseCase,
  ) : super(AcademicScheduleState(selectedDay: _getCurrentArabicDay()));

  final GetAcademicScheduleUseCase _getAcademicScheduleUseCase;
  final SaveStudentCredentialsUseCase _saveStudentCredentialsUseCase;
  final GetStudentCredentialsUseCase _getStudentCredentialsUseCase;

  static String _getCurrentArabicDay() {
    final now = DateTime.now();
    final days = {
      DateTime.monday: "الاثنين",
      DateTime.tuesday: "الثلاثاء",
      DateTime.wednesday: "الأربعاء",
      DateTime.friday: "الجمعة",
      DateTime.saturday: "السبت",
      DateTime.sunday: "الأحد",
    };
    return days[now.weekday] ?? "السبت";
  }

  final List<String> _days = [
    "السبت",
    "الأحد",
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
  ];

  List<String> get days => _days;
  Future<void> loadInitialData() async {
    emit(state.copyWith(academicScheduleState: AppStates.loading));
    final credentials = await _getStudentCredentialsUseCase();
    if (credentials == null) {
      emit(
        state.copyWith(
          isEditing: true,
          academicScheduleState: AppStates.initial,
        ),
      );
    } else {
      emit(state.copyWith(studentCredentials: credentials));
      await getAcademicSchedule(
        studentNationalId: credentials.studentNationalId,
        studentCode: credentials.studentCode,
      );
    }
  }

  void toggleEdit() {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  Future<void> getAcademicSchedule({
    String? studentCode,
    required String studentNationalId,
    bool forceRefresh = false,
  }) async {
    emit(
      state.copyWith(
        academicScheduleState: AppStates.loading,
        isEditing: false,
      ),
    );

    // Save credentials if they changed
    final newCredentials = StudentCredentialsModel(
      studentNationalId: studentNationalId,
      studentCode: studentCode,
    );
    await _saveStudentCredentialsUseCase(newCredentials);
    emit(state.copyWith(studentCredentials: newCredentials));

    final result = await _getAcademicScheduleUseCase(
      studentNationalId: studentNationalId,
      studentCode: studentCode,
      forceRefresh: forceRefresh,
    );

    result.when(
      onFailure: (failure) => emit(
        state.copyWith(
          academicScheduleState: AppStates.failure,
          error: failure,
        ),
      ),
      onSuccess: (scheduleItems) {
        emit(
          state.copyWith(
            academicScheduleState: AppStates.success,
            scheduleItems: scheduleItems,
          ),
        );
      },
    );
  }

  void selectDay(String day) {
    emit(state.copyWith(selectedDay: day));
  }
}
