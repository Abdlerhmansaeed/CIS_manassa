import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mansaa_app/features/auth/presentation/pages/forget_Password/credentials_retrieved_screen.dart';
import 'package:mansaa_app/features/auth/presentation/pages/forget_Password/forget_password_screen.dart';
import 'package:mansaa_app/features/auth/presentation/pages/login/login_screen.dart';
import 'package:mansaa_app/features/home/presentation/pages/home_screen.dart';
import 'package:mansaa_app/features/main_layout/presentation/main_layout_screen.dart';
import 'package:mansaa_app/features/my_courses/presentation/cubit/courses_cubit.dart';
import 'package:mansaa_app/features/my_courses/presentation/pages/course_details_screen.dart';
import 'package:mansaa_app/features/my_courses/presentation/pages/my_courses_screen.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';

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
      GoRoute(
        path: AppRouteNames.courseDetailsScreen,
        name: AppRouteNames.courseDetailsScreen,
        builder: (_, state) {
          final course = state.extra as StudentCourseResponse;
          return BlocProvider(
            create: (_) => getIt<CoursesCubit>(),
            child: CourseDetailsScreen(course: course),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteNames.home,
                name: AppRouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteNames.profile,
                name: AppRouteNames.profile,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteNames.myCoursesScreen,
                name: AppRouteNames.myCoursesScreen,
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<CoursesCubit>(),
                  child: const MyCoursesScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteNames.settings,
                name: AppRouteNames.settings,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

