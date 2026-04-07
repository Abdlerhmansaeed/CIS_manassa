import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_display_data.dart';
import 'task_item_widget.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

/// Pure renderer — receives pre-grouped, pre-formatted tasks from [HomeCubit].
/// Contains zero date arithmetic or business logic.
class UpcomingTasksWidget extends StatelessWidget {
  /// Pre-grouped map produced by [HomeCubit._buildDisplayData].
  /// Keys: 'Today', 'Tomorrow', 'Next Week', 'Later' (empty groups excluded).
  final Map<String, List<TaskDisplayData>> groupedEvents;

  const UpcomingTasksWidget({super.key, required this.groupedEvents});

  @override
  Widget build(BuildContext context) {
    if (groupedEvents.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UPCOMING TASKS',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: context.colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 16.h),
        ...groupedEvents.entries.expand((entry) {
          final isUrgentGroup = entry.key == 'Today';
          final indicatorColor = isUrgentGroup
              ? context.colors.error
              : context.colors.primary.withValues(alpha: 0.6);

          return [
            _GroupHeaderWidget(title: entry.key, color: indicatorColor),
            SizedBox(height: 12.h),
            ...entry.value.map(
              (taskData) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: TaskItemWidget(data: taskData),
              ),
            ),
            SizedBox(height: 12.h),
          ];
        }),
      ],
    );
  }
}

class _GroupHeaderWidget extends StatelessWidget {
  final String title;
  final Color color;

  const _GroupHeaderWidget({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
