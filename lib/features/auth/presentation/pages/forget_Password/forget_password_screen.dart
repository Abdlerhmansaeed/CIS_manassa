import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mansaa_app/features/auth/presentation/widgets/forget_password/blob_header.dart';
import 'package:mansaa_app/features/auth/presentation/widgets/forget_password/forget_password_from.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _studentCodeController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();

  @override
  void dispose() {
    _studentCodeController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Get Access'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: context.colors.primaryContainer,
            ),
            onPressed: () {
              if (context.canPop()) context.pop();
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [context.colors.surfaceContainer, context.colors.surface],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              children: [
                const ForgetPasswordBlobHeader(),
                const SizedBox(height: 40),
                Text(
                  'Retrieve Your Credentials',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Enter your details below to receive your Student ID and Password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 40),
                ForgetPasswordForm(
                  studentCodeController: _studentCodeController,
                  nationalIdController: _nationalIdController,
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
