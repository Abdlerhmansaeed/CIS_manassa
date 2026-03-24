import 'package:flutter/material.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';

class GapIndicator extends StatelessWidget {
  final String label;

  const GapIndicator({
    super.key,
    this.label = "1 HR GAP - BREAK",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildDashedLine(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurfaceVariant.withOpacity(0.5),
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: _buildDashedLine(),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.onSurfaceVariant.withOpacity(0.2),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
