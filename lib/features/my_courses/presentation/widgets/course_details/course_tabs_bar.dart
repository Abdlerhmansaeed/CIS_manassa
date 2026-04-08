import 'package:flutter/material.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

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
        color: context.colors.surfaceContainerLow, // surface-container-low
        borderRadius: BorderRadius.circular(9999),
      ),
      child: TabBar(
        controller: tabController,
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        indicator: BoxDecoration(
          color: context.colors.surfaceContainerLowest, // surface-container-lowest
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
