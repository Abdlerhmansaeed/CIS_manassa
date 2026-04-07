import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_state.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';

import '../widgets/welcome_section_widget.dart';
import '../widgets/weekly_schedule_widget.dart';
import '../widgets/urgent_task_widget.dart';
import '../widgets/upcoming_tasks_widget.dart';
import '../widgets/my_courses_widget.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = context.read<HomeCubit>();
    _homeCubit.getStudentCalenderRunningEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.colors.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const HomeAppBar(),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.studentRunningEventsState == AppStates.loading ||
                  state.studentRunningEventsState == AppStates.initial) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state.studentRunningEventsState == AppStates.failure) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.errorMessage ?? 'Error Loading Data',
                      style: TextStyle(color: context.colors.error),
                    ),
                  ),
                );
              }

              final data = state.displayData;
              if (data == null) {
                return const SliverFillRemaining(child: SizedBox());
              }

              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WelcomeSectionWidget(
                        userName: 'Ahmed',
                        tasksDueCounter: data.upcomingCount,
                        overdueCounter: data.overdueCount,
                      ),
                      SizedBox(height: 24.h),
                      WeeklyScheduleWidget(
                        weekDays: data.weekDays,
                        monthLabel: data.monthLabel,
                      ),
                      SizedBox(height: 24.h),
                      if (data.topUrgentEvent != null) ...[
                        UrgentTaskWidget(
                          deadlineText: data.topUrgentEvent!.overdue == true
                              ? 'Overdue!'
                              : 'Due Soon',
                          title:
                              data.topUrgentEvent!.name ??
                              data.topUrgentEvent!.activityname ??
                              'Task',
                          subtitle: data.topUrgentEvent!.course?.fullname ?? '',
                        ),
                        SizedBox(height: 24.h),
                      ],
                      UpcomingTasksWidget(groupedEvents: data.groupedEvents),
                      SizedBox(height: 24.h),
                      const MyCoursesWidget(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
