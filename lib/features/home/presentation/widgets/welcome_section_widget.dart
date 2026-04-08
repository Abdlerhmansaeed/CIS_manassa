import 'package:flutter/material.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/network/session/user_session.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class WelcomeSectionWidget extends StatelessWidget {
  final String userName;
  final int tasksDueCounter;
  final int overdueCounter;

  const WelcomeSectionWidget({
    super.key,
    required this.userName,
    required this.tasksDueCounter,
    required this.overdueCounter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning, ${getIt<UserSession>().userName()?.split(" ").first}${getIt<UserSession>().userName()?.split("").last}',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: context.colors.onSurface,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.assignment_late,
                size: 16.sp,
                color: context.colors.primary,
              ),
              SizedBox(width: 8.w),
              RichText(
                text: TextSpan(
                  text: '$tasksDueCounter tasks due this week and ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colors.onSurfaceVariant,
                    fontFamily: 'Be Vietnam Pro',
                  ),
                  children: [
                    TextSpan(
                      text: '$overdueCounter overdue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
