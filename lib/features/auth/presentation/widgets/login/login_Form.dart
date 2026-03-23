import 'package:flutter/material.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/core/widgets/shared_text_form_field.dart';
import 'package:resposive_xx/responsive/responsive.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController studentIdController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.studentIdController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);

  void toggleObscurePassword() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0.r, bottom: 8.0.r),
          child: Text(
            'Student ID',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        SharedTextFormField(
          controller: widget.studentIdController,
          hintText: 'Cxxxxxxx',
          prefixIcon: Icons.person_outline,
          // initialValue: context.read<AppManager>().state.isRememberMe
          //     ? context.read<AppManager>().state.userCode
          //     : null,
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            'Password',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _obscurePassword,
          builder: (context, value, child) {
            return SharedTextFormField(
              controller: widget.passwordController,
              hintText: '••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscurePassword.value,

              // initialValue: context.read<AppManager>().state.isRememberMe
              // ? context.rea/d<AppManager>().state.userPassword
              // : null,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: () {
                  toggleObscurePassword();
                },
              ),
            );
          },
          // child:
        ),
      ],
    );
  }
}
