import 'package:flutter/material.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';

class LectureCard extends StatelessWidget {
  final ScheduleItemModel item;
  final Color accentColor;

  const LectureCard({
    super.key,
    required this.item,
    this.accentColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isSection =
        (item.groupNumber != null &&
            item.groupNumber!.trim().isNotEmpty &&
            item.groupNumber != "0") ||
        (item.type?.contains("سيكشن") ?? false) ||
        (item.type?.contains("سكشن") ?? false);

    // Get a theme color based on course code or name
    final themeColor = _getCourseColor(item.subjectCode ?? "");

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Asymmetric Accent Border (Top-Left)
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Container(
            //     width: 80,
            //     height: 4,
            //     decoration: BoxDecoration(
            //       color: themeColor,
            //       borderRadius: const BorderRadius.only(
            //         bottomRight: Radius.circular(4),
            //       ),
            //     ),
            //   ),
            // ),

            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Container(
            //     width: 4,
            //     height: 60,
            //     decoration: BoxDecoration(
            //       color: themeColor,
            //       borderRadius: const BorderRadius.only(
            //         bottomRight: Radius.circular(4),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row: Time and Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            size: 16,
                            color: themeColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.period ?? "",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHighest.withOpacity(
                            0.5,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          (item.type ?? "LECTURE").toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Course Name
                  Text(
                    item.subjectName ?? "",
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Course Code and Group
                  Row(
                    children: [
                      Text(
                        item.subjectCode ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                      ),
                      if (isSection) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: themeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "GROUP ${item.groupNumber}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: themeColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Footer Rows: Instructor and Location
                  _buildIconDetail(Icons.person_pin, item.doctor ?? ""),
                  const SizedBox(height: 10),
                  _buildIconDetail(Icons.location_on, item.place ?? ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconDetail(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Color _getCourseColor(String code) {
    if (code.contains("CS333")) return const Color(0xFFD32F2F); // Red
    if (code.contains("CS361")) return const Color(0xFF1976D2); // Blue
    if (code.contains("CS362")) return const Color(0xFF388E3C); // Green
    if (code.contains("CS363")) return const Color(0xFF7B1FA2); // Purple
    if (code.contains("CS371")) return const Color(0xFFF57C00); // Orange
    return AppColors.primary;
  }
}
