import 'package:equatable/equatable.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';

import 'package:mansaa_app/features/academic_schedule/data/models/student_credentials_model.dart';

class AcademicScheduleState extends Equatable {
  final List<ScheduleItemModel> scheduleItems;
  final AppStates academicScheduleState;
  final String? error;
  final String selectedDay;
  final bool isEditing;
  final StudentCredentialsModel? studentCredentials;

  const AcademicScheduleState({
    this.scheduleItems = const [],
    this.academicScheduleState = AppStates.initial,
    this.error,
    this.selectedDay = "",
    this.isEditing = false,
    this.studentCredentials,
  });

  AcademicScheduleState copyWith({
    List<ScheduleItemModel>? scheduleItems,
    AppStates? academicScheduleState,
    String? error,
    String? selectedDay,
    bool? isEditing,
    StudentCredentialsModel? studentCredentials,
  }) {
    return AcademicScheduleState(
      scheduleItems: scheduleItems ?? this.scheduleItems,
      academicScheduleState:
          academicScheduleState ?? this.academicScheduleState,
      error: error ?? this.error,
      selectedDay: selectedDay ?? this.selectedDay,
      isEditing: isEditing ?? this.isEditing,
      studentCredentials: studentCredentials ?? this.studentCredentials,
    );
  }

  List<ScheduleItemModel> get filteredItems {
    final filtered = scheduleItems.where((item) {
      return _normalize(item.day ?? "") == _normalize(selectedDay);
    }).toList();

    // Sort by time
    filtered.sort((a, b) => a.startTimeMinutes.compareTo(b.startTimeMinutes));
    return filtered;
  }

  static String _normalize(String input) {
    return input
        .replaceAll("أ", "ا")
        .replaceAll("إ", "ا")
        .replaceAll("آ", "ا")
        .replaceAll("ة", "ه")
        .trim();
  }

  @override
  List<Object?> get props => [
    scheduleItems,
    academicScheduleState,
    error,
    selectedDay,
    isEditing,
  ];
}
