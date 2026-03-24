import 'package:flutter/material.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';

class CourseTabsBar extends StatelessWidget {
  const CourseTabsBar({
    super.key,
    required this.selectedIndex,
    required this.tabController,
    // required this.onTabSelected,
  });

  final int selectedIndex;
  final TabController tabController;
  // final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final tabs = ['Content', 'Grades'];

    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow, // surface-container-low
        borderRadius: BorderRadius.circular(9999),
      ),
      child: TabBar(
        controller: tabController,
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: EdgeInsets.all(16),
        padding: EdgeInsets.all(8),
        indicator: BoxDecoration(
          color: AppColors.surfaceContainerLowest, // surface-container-lowest
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
