import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class CoursesErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;
  const CoursesErrorView({super.key, this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded, size: 64.sp, color: Colors.grey[400]),
            SizedBox(height: 16.h),
            Text(
              message ?? 'Failed to load courses',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
