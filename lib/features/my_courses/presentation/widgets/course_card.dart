import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive.dart';


class CourseCard extends StatelessWidget {
  final String code;
  final String title;
  final String? instructor;
  final Color headerColor;
  final VoidCallback? onTap;
  final String? courseImage;

  const CourseCard({
    super.key,
    required this.code,
    required this.title,
    this.instructor,
    required this.headerColor,
    this.onTap,
    this.courseImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(), _buildContent()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 32.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        code,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if (instructor != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    instructor!,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
          if (courseImage != null) ...[
            SizedBox(width: 12.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                courseImage ?? "",
                width: 56.w,
                height: 56.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
