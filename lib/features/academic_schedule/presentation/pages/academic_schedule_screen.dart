import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/cubit/academic_schedule_cubit.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/cubit/academic_schedule_state.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/date_selector.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/lecture_card.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/schedule_header.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/gap_indicator.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';

class AcademicScheduleScreen extends StatefulWidget {
  const AcademicScheduleScreen({super.key});

  @override
  State<AcademicScheduleScreen> createState() => _AcademicScheduleScreenState();
}

class _AcademicScheduleScreenState extends State<AcademicScheduleScreen> {
  late final AcademicScheduleCubit _cubit;

  final List<String> _days = [
    "السبت",
    "الأحد",
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    // "الخميس",
  ];

  @override
  void initState() {
    _cubit = getIt<AcademicScheduleCubit>()
      ..getAcademicSchedule(
        studentNationalId: "30401151403971",
        studentCode: "C2303024",
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: BlocBuilder<AcademicScheduleCubit, AcademicScheduleState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.academicScheduleState == AppStates.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.academicScheduleState == AppStates.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.error ?? "Failed to load schedule",
                    style: const TextStyle(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _cubit.getAcademicSchedule(
                      studentNationalId: "30401151403971",
                      studentCode: "C2303024",
                    ),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          final items = state.filteredItems;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScheduleHeader(
                  title: "My Schedule",
                  subtitle: "Week 12 · Spring 2025",
                ),
                DateSelector(
                  days: _days,
                  selectedDay: state.selectedDay,
                  onDaySelected: (day) => _cubit.selectDay(day),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: items.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final current = items[index];
                            Widget card = LectureCard(item: current);

                            if (index < items.length - 1) {
                              final next = items[index + 1];
                              if (_hasGap(current, next)) {
                                return Column(
                                  children: [card, const GapIndicator()],
                                );
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: card,
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 64,
            color: AppColors.onSurfaceVariant.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            "No entries for this day",
            style: TextStyle(
              color: AppColors.onSurfaceVariant.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  bool _hasGap(ScheduleItemModel current, ScheduleItemModel next) {
    try {
      final currentEnd = _extractTime(current.period?.split('-').last ?? "");
      final nextStart = _extractTime(next.period?.split('-').first ?? "");

      if (currentEnd.isEmpty || nextStart.isEmpty) return false;

      // Simple string comparison for now, as university times are usually consistent
      return currentEnd != nextStart;
    } catch (_) {
      return false;
    }
  }

  String _extractTime(String text) {
    // Extract something like "١٠:١٥" or "10:15"
    final regExp = RegExp(r'([٠-٩0-9]+:[٠-٩0-9]+)');
    final match = regExp.firstMatch(text);
    return match?.group(0) ?? "";
  }
}
