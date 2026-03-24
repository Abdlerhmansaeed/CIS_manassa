import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/features/academic_schedule/domain/usecases/get_acadmic_schedule_use_case.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/cubit/academic_schedule_state.dart';

// part 'academic_schedule_state.dart';
@injectable
class AcademicScheduleCubit extends Cubit<AcademicScheduleState> {
  AcademicScheduleCubit(this._getAcademicScheduleUseCase)
    : super(AcademicScheduleState(selectedDay: _getCurrentArabicDay()));

  final GetAcademicScheduleUseCase _getAcademicScheduleUseCase;

  static String _getCurrentArabicDay() {
    final now = DateTime.now();
    final days = {
      DateTime.monday: "الاثنين",
      DateTime.tuesday: "الثلاثاء",
      DateTime.wednesday: "الأربعاء",
      // DateTime.thursday: "الخميس",
      DateTime.friday: "الجمعة",
      DateTime.saturday: "السبت",
      DateTime.sunday: "الأحد",
    };
    return days[now.weekday] ?? "السبت";
  }

  Future<void> getAcademicSchedule({
    String? studentCode,
    required String studentNationalId,
  }) async {
    emit(state.copyWith(academicScheduleState: AppStates.loading));
    final result = await _getAcademicScheduleUseCase.call(
      studentNationalId: studentNationalId,
      studentCode: studentCode,
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
