import 'package:flutter/material.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';

class ForgetPasswordBlobHeader extends StatelessWidget {
  const ForgetPasswordBlobHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: RadialGradient(
          center: const Alignment(-0.6, -0.4),
          radius: 0.8,
          colors: [
            const Color(0xFFFFDCD7).withOpacity(0.5),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: RadialGradient(
                  center: const Alignment(0.6, 0.4),
                  radius: 0.8,
                  colors: [
                    AppColors.secondaryContainer.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Adding a subtle grid pattern / opacity effect if possible, or just a translucent layout
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest.withOpacity(0.9),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F1E1B15),
                    blurRadius: 48,
                    offset: Offset(0, 24),
                  ),
                ],
              ),
              child: const Icon(
                Icons.security_rounded,
                color: AppColors.primary,
                size: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
