import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/cubit/academic_schedule_cubit.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/cubit/academic_schedule_state.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/academic_schedule_error_state_ui.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/academic_schedule_no_data.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/academic_schedule_shimmer.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/date_selector.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/get_academic_schedule_form.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/lecture_card.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/schedule_header.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/widgets/gap_indicator.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class AcademicScheduleScreen extends StatefulWidget {
  const AcademicScheduleScreen({super.key});

  @override
  State<AcademicScheduleScreen> createState() => _AcademicScheduleScreenState();
}

class _AcademicScheduleScreenState extends State<AcademicScheduleScreen> {
  late final AcademicScheduleCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  final _nationalIdController = TextEditingController();
  final _studentCodeController = TextEditingController();
  @override
  void initState() {
    _cubit = getIt<AcademicScheduleCubit>()..loadInitialData();
    super.initState();
  }

  @override
  void dispose() {
    _nationalIdController.dispose();
    _studentCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Academic Schedule",
            style: TextStyle(
              // color: context.colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            BlocBuilder<AcademicScheduleCubit, AcademicScheduleState>(
              buildWhen: (previous, current) =>
                  previous.isEditing != current.isEditing,
              builder: (context, state) {
                return TextButton.icon(
                  onPressed: () {
                    log("isEditing is Changing To: ${!state.isEditing}");
                    _cubit.toggleEdit();
                  },
                  icon: Icon(
                    state.isEditing ? Icons.close : Icons.edit_note,
                    // color: context.colors.primary,
                  ),
                  label: Text(
                    state.isEditing ? "Cancel" : "Another Student",
                    // style: TextStyle(color: context.colors.primary),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<AcademicScheduleCubit, AcademicScheduleState>(
          builder: (context, state) {
            if (state.isEditing == true) {
              return GetAcademicScheduleForm(
                nationalIdController: _nationalIdController,
                studentCodeController: _studentCodeController,
                formKey: _formKey,
                cubit: _cubit,
              );
            }

            if (state.academicScheduleState == AppStates.loading) {
              return const AcademicScheduleShimmer();
            }

            if (state.academicScheduleState == AppStates.failure) {
              return AcademicScheduleErrorStateUi(
                error: state.error,
                onTryAnotherStudentActionCalled: () => _cubit.toggleEdit(),
              );
            }

            final items = state.filteredItems;

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScheduleHeader(
                    title: "Student Schedule",
                    subtitle:
                        state.studentCredentials?.studentCode ?? "My Schedule",
                  ),
                  DateSelector(
                    days: _cubit.days,
                    selectedDay: state.selectedDay,
                    onDaySelected: (day) => _cubit.selectDay(day),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: items.isEmpty
                        ? const AcademicScheduleNoData()
                        : ListView.builder(
                            padding: EdgeInsets.fromLTRB(
                              24.w,
                              0.r,
                              24.r,
                              100.r,
                            ),
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
                                padding: EdgeInsets.only(bottom: 16.h),
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
      ),
    );
  }

  bool _hasGap(ScheduleItemModel current, ScheduleItemModel next) {
    try {
      final currentEnd = _extractTime(current.period?.split('-').last ?? "");
      final nextStart = _extractTime(next.period?.split('-').first ?? "");

      if (currentEnd.isEmpty || nextStart.isEmpty) return false;
      return currentEnd != nextStart;
    } catch (_) {
      return false;
    }
  }

  String _extractTime(String text) {
    final regExp = RegExp(r'([٠-٩0-9]+:[٠-٩0-9]+)');
    final match = regExp.firstMatch(text);
    return match?.group(0) ?? "";
  }
}
