import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_section_header.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.colors.surface,
      appBar: const _NotificationsAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 16.0.h),
          child: Column(
            children: [
              const NotificationSectionHeader(title: 'Today'),
              SizedBox(height: 12.h),
              const _TodayNotifications(),
              SizedBox(height: 24.h),
              const NotificationSectionHeader(title: 'Yesterday'),
              SizedBox(height: 12.h),
              const _YesterdayNotifications(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _NotificationsAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: context.colors.surfaceContainer.withAlpha(
      //   204,
      // ), // 80% opacity
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: context.colors.onSurface,
                  size: 24.r,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 8.w),
              Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
            ],
          ),
          TextButton(onPressed: () {}, child: const Text('Mark all as read')),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TodayNotifications extends StatelessWidget {
  const _TodayNotifications();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationCard(
          title: 'DEADLINE REMINDER',
          subtitle: 'Sheet 1 OS due in 2 hours',
          time: '9:45 AM',
          iconData: Icons.error,
          iconColor: context.colors.primary,
          iconBackgroundColor: Color(0x1AA0000A), // primary at 10%
          isUnread: true,
        ),
        SizedBox(height: 12.h),
        const NotificationCard(
          title: 'NEW FILE',
          subtitle: 'Dr. Ahmed uploaded Lecture 8 PDF in CS333',
          time: '8:30 AM',
          iconData: Icons.description,
          iconColor: Color(0xFF004E8F), // tertiary
          iconBackgroundColor: Color(0x1A004E8F), // tertiary at 10%
          isUnread: false,
        ),
        SizedBox(height: 12.h),
        const NotificationCard(
          title: 'QUIZ ALERT',
          subtitle: 'Data Structures quiz starts in 24 hours',
          time: '7:00 AM',
          iconData: Icons.timer,
          iconColor: AppColors.amber,
          iconBackgroundColor: Color(0x1AFFC107), // amber at 10%
          isUnread: false,
        ),
      ],
    );
  }
}

class _YesterdayNotifications extends StatelessWidget {
  const _YesterdayNotifications();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationCard(
          title: 'SUBMITTED',
          subtitle: 'Lab Report 2 marked as received',
          time: '11:58 PM',
          iconData: Icons.check_circle,
          iconColor: Colors.green, // emerald-600 approx
          iconBackgroundColor: Color(0x1A4CAF50), // emerald at 10%
          isUnread: false,
        ),
        SizedBox(height: 12.h),
        const NotificationCard(
          title: 'NEW FILE',
          subtitle: '2 new files in CS211 - Slides',
          time: '3:00 PM',
          iconData: Icons.folder_shared,
          iconColor: Color(0xFF004E8F), // tertiary
          iconBackgroundColor: Color(0x1A004E8F), // tertiary at 10%
          isUnread: false,
        ),
      ],
    );
  }
}
