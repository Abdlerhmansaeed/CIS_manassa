import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.studentId,
    required this.imageUrl,
    required this.badgeLevel,
  });

  final String name;
  final String studentId;
  final String imageUrl;
  final String badgeLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.colors.primaryContainer,
            context.colors.primary,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28.r),
          bottomRight: Radius.circular(28.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 48.h, bottom: 40.h, left: 24.w, right: 24.w),
      child: Column(
        children: [
          _buildAvatarContainer(context),
          SizedBox(height: 16.h),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: context.colors.onPrimary,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            studentId,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: context.colors.onPrimary.withOpacity(0.8),
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 20.h),
          _buildBadge(context),
        ],
      ),
    );
  }

  Widget _buildAvatarContainer(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 96.w,
          height: 96.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
            border: Border.all(color: Colors.white, width: 3.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person, color: Colors.white, size: 48.sp);
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade400,
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.primaryContainer, width: 4.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.colors.onPrimary,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            color: context.colors.primaryContainer,
            size: 14.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            badgeLevel,
            style: TextStyle(
              color: context.colors.primaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
