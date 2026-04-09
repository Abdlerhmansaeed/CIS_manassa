import 'package:flutter/material.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';

class SegmentedControl extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.isCompact = false,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: context.colors.outlineVariant.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          final isSelected = index == selectedIndex;
          return _Segment(
            label: options[index],
            isSelected: isSelected,
            isCompact: isCompact,
            onTap: () => onChanged(index),
          );
        }),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isCompact = false,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 12.w : 16.w,
          vertical: isCompact ? 6.h : 8.h,
        ),
        decoration: isSelected
            ? BoxDecoration(
                color: context.colors.primaryContainer,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              )
            : const BoxDecoration(),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? context.colors.onPrimary
                : context.colors.onSurfaceVariant.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
