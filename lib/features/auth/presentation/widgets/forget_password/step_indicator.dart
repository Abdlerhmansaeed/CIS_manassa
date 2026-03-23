import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_state.dart';

class ForgetPasswordStepIndicator extends StatelessWidget {
  final AuthCubit authCubit;
  const ForgetPasswordStepIndicator({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: authCubit,
      buildWhen: (previous, current) {
        return previous.getAccessForCredentialsStep !=
            current.getAccessForCredentialsStep;
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepItem(
              stepNumber: "1",
              label: "Student Code",
              isActive: state.getAccessForCredentialsStep >= 1,
            ),
            AnimatedCrossFade(
              firstChild: Container(
                width: 64,
                height: 1,
                color: AppColors.surfaceContainerHighest,
                margin: const EdgeInsets.only(bottom: 24),
              ),
              secondChild: Container(
                width: 64,
                height: 1,
                color: AppColors.primary,
                margin: const EdgeInsets.only(bottom: 24),
              ),
              crossFadeState: state.getAccessForCredentialsStep == 0
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 500),
            ),
            _buildStepItem(
              stepNumber: "2",
              label: "National ID",
              isActive: state.getAccessForCredentialsStep >= 2,
            ),
          ],
        );
      },
      // child:
    );
  }

  Widget _buildStepItem({
    required String stepNumber,
    required String label,
    required bool isActive,
  }) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : Colors.transparent,
            border: isActive ? null : Border.all(color: AppColors.outline),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            stepNumber,
            style: TextStyle(
              color: isActive
                  ? AppColors.onPrimary
                  : AppColors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? AppColors.primary : AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
