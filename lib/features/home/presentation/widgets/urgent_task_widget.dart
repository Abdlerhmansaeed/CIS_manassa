import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class UrgentTaskWidget extends StatelessWidget {
  final String deadlineText;
  final String title;
  final String subtitle;

  const UrgentTaskWidget({
    super.key,
    required this.deadlineText,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDAD6).withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFBA1A1A).withOpacity(0.1)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -10.h,
            right: -10.w,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.alarm,
                size: 64.sp,
                color: const Color(0xFFBA1A1A),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBA1A1A),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'DUE TODAY',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    deadlineText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFBA1A1A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  elevation: 2,
                  shadowColor: context.colors.primary.withOpacity(0.2),
                ),
                child: Text(
                  'Submit Now',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
