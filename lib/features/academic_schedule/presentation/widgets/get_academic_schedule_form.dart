import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/core/widgets/shared_text_form_field.dart';
import 'package:mansaa_app/features/academic_schedule/presentation/cubit/academic_schedule_cubit.dart';

class GetAcademicScheduleForm extends StatelessWidget {
  final TextEditingController _nationalIdController;
  final TextEditingController _studentCodeController;
  final GlobalKey<FormState> _formKey;
  final AcademicScheduleCubit _cubit;
  const GetAcademicScheduleForm({
    super.key,
    required TextEditingController nationalIdController,
    required TextEditingController studentCodeController,
    required GlobalKey<FormState> formKey,
    required AcademicScheduleCubit cubit,
  }) : _nationalIdController = nationalIdController,
       _studentCodeController = studentCodeController,
       _formKey = formKey,
       _cubit = cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.school_outlined,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            const Text(
              "Get Schedule",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Enter your details below to fetch your Academic Schedule.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'Student Code',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ),
            SharedTextFormField(
              hintText: 'Enter your student code',
              prefixIcon: Icons.badge_outlined,
              controller: _studentCodeController,
              validator: (value) => null, // Optional as per user
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Provided by the university',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'National ID',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ),
            SharedTextFormField(
              hintText: 'Enter your 14-digit national ID',
              prefixIcon: Icons.fingerprint_outlined,
              controller: _nationalIdController,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  (value == null || value.isEmpty) ? "Required" : null,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _cubit.state.academicScheduleState.isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        _cubit.getAcademicSchedule(
                          studentNationalId: _nationalIdController.text.trim(),
                          studentCode:
                              _studentCodeController.text.trim().isEmpty
                              ? null
                              : _studentCodeController.text.trim(),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _cubit.state.academicScheduleState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Get My Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}
