import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/core/widgets/shared_text_form_field.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:mansaa_app/features/auth/presentation/widgets/forget_password/step_indicator.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
    required this.studentCodeController,
    required this.nationalIdController,
  });

  final TextEditingController studentCodeController;
  final TextEditingController nationalIdController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.credentialsState != current.credentialsState,
      listener: (context, state) {
        if (state.credentialsState == AppStates.success &&
            state.credentialResponse != null) {
          context.pushNamed(
            AppRouteNames.credentialsRetrievedScreen,
            extra: state.credentialResponse,
          );
        } else if (state.credentialsState == AppStates.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? 'Failed to retrieve credentials',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.credentialsState != current.credentialsState,
      builder: (context, state) {
        final isLoading = state.credentialsState == AppStates.loading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ForgetPasswordStepIndicator(authCubit: context.read<AuthCubit>()),
            const SizedBox(height: 32),
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
              controller: studentCodeController,
              onChanged: (value) {
                if (value.isEmpty || value.length < 7) {
                  context.read<AuthCubit>().updateGetAccessForCredentialsStep(
                    currentStep: 1,
                  );
                }
              },
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
              controller: nationalIdController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isEmpty || value.length < 14) {
                  context.read<AuthCubit>().updateGetAccessForCredentialsStep(
                    currentStep: 2,
                  );
                }
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (studentCodeController.text.trim().isEmpty ||
                          nationalIdController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter Student Code and National ID',
                            ),
                          ),
                        );
                        return;
                      }
                      context.read<AuthCubit>().getCredentials(
                        studentId: studentCodeController.text.trim(),
                        nationalNumber: nationalIdController.text.trim(),
                      );
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Get My Credentials'),
            ),
          ],
        );
      },
    );
  }
}
