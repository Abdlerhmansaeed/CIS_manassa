import 'package:flutter/material.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';

class AcademicScheduleNoData extends StatelessWidget {
  const AcademicScheduleNoData({super.key});

  @override
  Widget build(BuildContext context) {
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
}
