import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:mansaa_app/features/auth/presentation/widgets/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthCubit _cubit;
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        buildWhen: (previous, current) {
          return previous.loginState != current.loginState;
        },
        listenWhen: (previous, current) {
          return previous.loginState != current.loginState;
        },
        listener: (context, state) {
          if (state.loginState == AppStates.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Login Success')),
            );
            context.goNamed(AppRouteNames.home);
          } else if (state.loginState == AppStates.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Login failed'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 48.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Section
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.onSurface.withOpacity(0.08),
                          blurRadius: 48,
                          offset: const Offset(0, 24),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.school_outlined,
                      color: AppColors.onPrimary,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'CIS Student Hub',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your academic life, simplified.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 40),
                  LoginForm(
                    studentIdController: _studentIdController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 24),

                  // Actions Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BlocBuilder<AuthCubit, AuthState>(
                            buildWhen: (previous, current) {
                              return previous.shouldRememberMe !=
                                  current.shouldRememberMe;
                            },
                            builder: (context, state) {
                              return Switch.adaptive(
                                value: state.shouldRememberMe,
                                onChanged: (value) {
                                  _cubit.toggleRememberMe(
                                    shouldRememberMe: value,
                                  );
                                },
                                activeColor: AppColors.primary,
                                activeTrackColor: AppColors.primary.withOpacity(
                                  0.2,
                                ),
                                inactiveThumbColor: AppColors.onSurfaceVariant,
                                inactiveTrackColor:
                                    AppColors.surfaceContainerHighest,
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Remember Me',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(AppRouteNames.getPasswordsScreen);
                        },
                        child: const Text(
                          'Forgot Password? Get Access',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.loginState == AppStates.loading
                          ? null
                          : () async {
                              if (_studentIdController.text.trim().isEmpty ||
                                  _passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please enter Student ID and Password',
                                    ),
                                  ),
                                );
                                return;
                              }
                              await _cubit.loginStudent(
                                studentCode: _studentIdController.text.trim(),
                                studentPassword: _passwordController.text,
                              );
                            },
                      child: state.loginState == AppStates.loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Sign In'),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _footerLink('Privacy Policy'),
                      const SizedBox(width: 24),
                      _footerLink('Terms of Service'),
                      const SizedBox(width: 24),
                      _footerLink('Help Desk'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _footerLink(String text) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          color: Colors.grey,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
