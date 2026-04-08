import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.w, bottom: 12.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: context.colors.onSurfaceVariant.withOpacity(0.6),
              letterSpacing: 0.5,
            ),
          ),
        ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
