import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_state.dart';
import 'package:mansaa_app/features/home/presentation/widgets/quiz_details_bottom_sheet.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_display_data.dart';

/// Pure renderer — receives pre-computed [TaskDisplayData] from [HomeCubit].
class TaskItemWidget extends StatelessWidget {
  final TaskDisplayData data;

  const TaskItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isQuiz = data.eventType == EventType.quiz;
    final bool showStatus = isQuiz ? data.isStarted : true;
    final Color mainColor = data.isOverdue
        ? AppColors.error
        : AppColors.primary;

    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: (data.isOverdue && showStatus)
            ? AppColors.errorContainer.withValues(alpha: 0.1)
            : AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: (data.isOverdue && showStatus)
              ? AppColors.error.withValues(alpha: 0.2)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _CategoryBadge(
                label: isQuiz ? 'QUIZ' : 'ASSIGNMENT',
                color: isQuiz ? Colors.amber : mainColor,
                icon: isQuiz ? Icons.timer_outlined : Icons.assignment_outlined,
              ),
              const Spacer(),
              if (showStatus) ...[
                if (data.isOverdue)
                  const _StatusBadge(label: 'OVERDUE', color: AppColors.error)
                else if (data.timeText.isNotEmpty)
                  _StatusBadge(
                    label: 'DUE',
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
              ],
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      data.courseName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (data.timeText.isNotEmpty) ...[
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _resolveTimeValue(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: (data.isOverdue && showStatus)
                            ? AppColors.error
                            : AppColors.primary,
                      ),
                    ),
                    Text(
                      _resolveTimeLabel(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          if (isQuiz) ...[
            SizedBox(height: 12.h),
            BlocConsumer<HomeCubit, HomeState>(
              buildWhen: (previous, current) {
                return previous.quizDetailsState != current.quizDetailsState;
              },
              listenWhen: (previous, current) {
                return current.quizDetailsState != previous.quizDetailsState;
              },
              listener: (context, state) {
                if (state.quizDetailsState.isSuccess &&
                    state.quizDetails != null) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return QuizDetailsBottomSheet(quiz: state.quizDetails!);
                    },
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state.quizDetailsState.isLoading;
                return OutlinedButton(
                  onPressed: () {
                    final courseId = data.event.course?.id;
                    final quizId = data.event.instance;
                    if (courseId != null && quizId != null) {
                      context.read<HomeCubit>().getQuizDetails(
                        courseId: courseId,
                        quizId: quizId,
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.amber,
                    side: const BorderSide(color: Colors.amber),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? SizedBox(
                              height: 15.h,
                              width: 15.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Icon(Icons.info_outline, size: 16.sp),
                      SizedBox(width: 8.w),
                      Text(
                        isLoading ? "Loading..." : 'Show details',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          if (data.showAction) ...[
            SizedBox(height: isQuiz ? 8.h : 16.h),
            ElevatedButton(
              onPressed: () {
                // Navigate via Cubit action or direct link
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.event.action?.name ??
                        (isQuiz ? 'Start Quiz' : 'Submit'),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward_rounded, size: 16.sp),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _resolveTimeValue() {
    if (data.eventType == EventType.quiz) {
      return data.isStarted
          ? (data.endTimeText ?? '')
          : (data.startTimeText ?? '');
    }
    return data.timeText;
  }

  String _resolveTimeLabel() {
    if (data.eventType == EventType.quiz) {
      return data.isStarted ? 'Ends at' : 'Starts at';
    }
    return 'Deadline';
  }
}

class _CategoryBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _CategoryBadge({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
