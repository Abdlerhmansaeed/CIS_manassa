import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_display_data.dart';

/// Pure renderer — receives pre-computed [WeekDayData] from [HomeCubit].
/// Contains zero business logic, date arithmetic, or epoch conversions.
class WeeklyScheduleWidget extends StatelessWidget {
  final List<WeekDayData> weekDays;
  final String monthLabel;

  const WeeklyScheduleWidget({
    super.key,
    required this.weekDays,
    required this.monthLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'WEEKLY SCHEDULE',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            Text(
              monthLabel,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: weekDays.map((day) {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: _DayItemWidget(day: day),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _DayItemWidget extends StatelessWidget {
  final WeekDayData day;

  const _DayItemWidget({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 54.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: day.isToday
            ? AppColors.primary
            : AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: day.isToday
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
        border: day.isToday
            ? null
            : Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Text(
            day.label.toUpperCase(),
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: day.isToday
                  ? Colors.white.withValues(alpha: 0.8)
                  : AppColors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            day.dateNumber,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: day.isToday ? Colors.white : AppColors.onSurface,
            ),
          ),
          if (day.isToday || day.dots.isNotEmpty) SizedBox(height: 4.h),
          if (day.isToday)
            Container(
              width: 4.w,
              height: 4.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            )
          else if (day.dots.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: day.dots.map((color) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Container(
                    width: 4.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
