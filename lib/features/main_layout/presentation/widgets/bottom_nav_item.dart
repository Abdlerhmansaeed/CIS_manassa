import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resposive_xx/responsive/responsive.dart';

class BottomNavItem extends StatelessWidget {
  final int index;
  final IconData? icon;
  final String label;
  final StatefulNavigationShell navigationShell;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  const BottomNavItem({
    super.key,
    required this.index,
    this.icon,
    required this.label,
    required this.navigationShell,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedPadding(
              padding: EdgeInsets.symmetric(vertical: isSelected ? 1.5 : 0),
              duration: const Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                transformAlignment: Alignment.center,
                transform: Matrix4.translationValues(0, isSelected ? 0 : 5, 2),
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: isSelected ? 23.w : 0.w,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected
                      ? activeColor.withOpacity(0.15)
                      : Colors.transparent,
                ),
                child: Icon(
                  icon,
                  color: isSelected ? activeColor : inactiveColor,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? activeColor : inactiveColor,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   Widget _buildNavItem({
//     required int index,
//     IconData? icon,
//     required String label,
//   }) {
//     final bool isSelected = navigationShell.currentIndex == index;
//     final Color activeColor = AppColors.yelloColor;
//     final Color inactiveColor = AppColors.grayColor;

//     return
//   }
// }
