import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mansaa_app/features/auth/presentation/pages/forget_Password/credentials_retrieved_screen.dart';
import 'package:mansaa_app/features/auth/presentation/pages/forget_Password/forget_password_screen.dart';
import 'package:mansaa_app/features/auth/presentation/pages/login/login_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRouteNames.login,
    routes: [
      GoRoute(
        path: AppRouteNames.login,
        name: AppRouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteNames.getPasswordsScreen,
        name: AppRouteNames.getPasswordsScreen,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRouteNames.credentialsRetrievedScreen,
        name: AppRouteNames.credentialsRetrievedScreen,
        builder: (context, state) {
          final credentials = state.extra as CredentialResponse?;
          if (credentials == null) {
            return const ForgetPasswordScreen();
          }
          return CredentialsRetrievedScreen(credentials: credentials);
        },
      ),
    ],
  );
}
