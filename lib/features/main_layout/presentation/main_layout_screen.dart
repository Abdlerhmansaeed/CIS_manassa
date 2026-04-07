import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/features/main_layout/presentation/widgets/bottom_nav_item.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class MainLayoutScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayoutScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            BottomNavItem(
              index: 0,
              icon: Icons.home_rounded,
              label: 'Home',
              navigationShell: navigationShell,
              isSelected: navigationShell.currentIndex == 0,
              activeColor: context.colors.primaryContainer,
              inactiveColor: context.colors.onSurfaceVariant,
            ),
            BottomNavItem(
              index: 1,
              icon: Icons.schedule,
              label: 'Schedule',
              navigationShell: navigationShell,
              isSelected: navigationShell.currentIndex == 1,
              activeColor: context.colors.primaryContainer,
              inactiveColor: context.colors.onSurfaceVariant,
            ),
            BottomNavItem(
              index: 2,
              icon: Icons.book,
              label: 'My Courses',
              navigationShell: navigationShell,
              isSelected: navigationShell.currentIndex == 2,
              activeColor: context.colors.primaryContainer,
              inactiveColor: context.colors.onSurfaceVariant,
            ),
            BottomNavItem(
              index: 3,
              icon: Icons.person_2_rounded,
              label: 'profile',
              navigationShell: navigationShell,
              isSelected: navigationShell.currentIndex == 3,
              activeColor: context.colors.primaryContainer,
              inactiveColor: context.colors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
