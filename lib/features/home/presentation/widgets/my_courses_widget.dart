import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'course_item_widget.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class MyCoursesWidget extends StatelessWidget {
  const MyCoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MY COURSES',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              CourseItemWidget(
                code: 'CS333',
                title: 'Operating Systems',
                subtitle: 'Section A • Dr. Sarah',
                progress: 65,
                themeColor: context.colors.primary,
                hasNotification: true,
              ),
              SizedBox(width: 16.w),
              const CourseItemWidget(
                code: 'CS402',
                title: 'Artificial Intelligence',
                subtitle: 'Section C • Prof. K',
                progress: 42,
                themeColor: Color(0xFF004E8F), // tertiary
              ),
            ],
          ),
        ),
      ],
    );
  }
}
