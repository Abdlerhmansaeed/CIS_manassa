import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h, bottom: 24.h),
      width: double.infinity,
      height: 56.h,
      child: Material(
        color: context.colors.primaryContainer.withOpacity(0.05),
        borderRadius: BorderRadius.circular(28.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: context.colors.primaryContainer.withOpacity(0.2),
                width: 1.5.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "تسجيل الخروج",
                  style: TextStyle(
                    color: context.colors.primaryContainer,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.logout,
                  color: context.colors.primaryContainer,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
