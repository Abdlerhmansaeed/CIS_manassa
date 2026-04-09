import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/core/widgets/animated_dialogs.dart';
import 'package:mansaa_app/core/widgets/failure_message_mapper.dart';
import 'package:mansaa_app/core/widgets/shared_text_form_field.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:mansaa_app/features/auth/presentation/widgets/forget_password/step_indicator.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';
import 'package:mansaa_app/core/extensions/localization_extension.dart';

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
        if (state.credentialsState.isSuccess &&
            state.credentialResponse != null) {
          context.pushNamed(
            AppRouteNames.credentialsRetrievedScreen,
            extra: state.credentialResponse,
          );
        } else if (state.credentialsState.isFailure) {
          context.showFailureAction(
            title: context.l10n.errorGettingCredentials,
            message:
                state.failure?.toUserMessage(context) ??
                context.l10n.failedToRetrieveCredentials,
            buttonText: context.l10n.ok,
            onButtonPressed: () {
              context.pop();
            },
            customization: DialogCustomization(messageFontSize: 14.sp),
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.credentialsState != current.credentialsState,
      builder: (context, state) {
        final isLoading = state.credentialsState.isLoading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ForgetPasswordStepIndicator(authCubit: context.read<AuthCubit>()),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                context.l10n.studentCode,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
            ),
            SharedTextFormField(
              hintText: context.l10n.studentCodeHint,
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
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                context.l10n.providedByUniversity,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                context.l10n.nationalId,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
            ),
            SharedTextFormField(
              hintText: context.l10n.nationalIdHint,
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
                            SnackBar(
                              content: Text(
                                context.l10n.getAccessPrompt,
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
                  : Text(context.l10n.getMyCredentials),
            ),
          ],
        );
      },
    );
  }
}
