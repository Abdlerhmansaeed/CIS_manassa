import 'package:flutter/material.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
// import 'package:mansaa_app/features/academic_schedule/presentation/cubit/academic_schedule_cubit.dart';

class AcademicScheduleErrorStateUi extends StatelessWidget {
  // final AcademicScheduleCubit _cubit;
  final String? error;
  final VoidCallback onTryAnotherStudentActionCalled;
  const AcademicScheduleErrorStateUi({
    super.key,
    // required AcademicScheduleCubit cubit,
    required this.error,
    required this.onTryAnotherStudentActionCalled,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            error ?? "Failed to load schedule",
            style: TextStyle(color: context.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => onTryAnotherStudentActionCalled(),
            child: const Text("Try Another Student"),
          ),
        ],
      ),
    );
  }
}
