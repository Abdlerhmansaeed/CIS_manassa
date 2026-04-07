import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive_x.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationSectionHeader extends StatelessWidget {
  final String title;

  const NotificationSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: AppColors.onSurfaceVariant,
                ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Container(
              height: 1.h,
              color: AppColors.outline.withAlpha(76), // 30% opacity
            ),
          ),
        ],
      ),
    );
  }
}
