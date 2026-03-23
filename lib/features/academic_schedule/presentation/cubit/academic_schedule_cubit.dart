import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'academic_schedule_state.dart';

class AcademicScheduleCubit extends Cubit<AcademicScheduleState> {
  AcademicScheduleCubit() : super(AcademicScheduleInitial());
}
