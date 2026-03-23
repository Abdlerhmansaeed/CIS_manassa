import 'package:flutter/material.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';

class CourseTabsBar extends StatelessWidget {
  const CourseTabsBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final tabs = ['Content', 'Grades'];

    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow, // surface-container-low
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors
                            .surfaceContainerLowest // surface-container-lowest
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withAlpha(13),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primaryContainer
                        : AppColors.onSurfaceVariant, // on-surface-variant
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
