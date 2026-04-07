import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/my_courses/presentation/cubit/courses_cubit.dart';
import 'package:mansaa_app/features/my_courses/presentation/cubit/courses_state.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_card.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/courses_error_view.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/courses_shimmer.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';

// ─────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CoursesCubit>().loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: BlocConsumer<CoursesCubit, CoursesState>(
          listener: _onStateChanged,
          buildWhen: (previous, current) =>
              previous.coursesState != current.coursesState,
          listenWhen: (previous, current) =>
              previous.coursesState != current.coursesState,
          builder: (context, state) => RefreshIndicator(
            color: AppColors.primary,
            onRefresh: context.read<CoursesCubit>().refreshCourses,
            child: _CoursesScrollView(state: state),
          ),
        ),
      ),
    );
  }

  /// Shows a snackbar when the API fails but stale data is still available.
  void _onStateChanged(BuildContext context, CoursesState state) {
    final hasStaleData =
        state.coursesState.isFailure && state.courses.isNotEmpty;
    if (!hasStaleData) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.errorMessage ?? 'Could not refresh courses'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

class _CoursesScrollView extends StatelessWidget {
  const _CoursesScrollView({required this.state});

  final CoursesState state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CoursesTitle(count: state.courses.length),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
        _CoursesBody(state: state),

        // Bottom padding sliver
        SliverToBoxAdapter(child: SizedBox(height: 40.h)),
      ],
    );
  }
}

class _CoursesTitle extends StatelessWidget {
  const _CoursesTitle({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My Courses',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: -1,
          ),
        ),
        if (count > 0) ...[
          SizedBox(height: 8.h),
          Text(
            '$count subjects',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}

class _CoursesBody extends StatelessWidget {
  const _CoursesBody({required this.state});

  final CoursesState state;

  @override
  Widget build(BuildContext context) {
    if (state.coursesState.isLoading) {
      return const SliverToBoxAdapter(child: CoursesShimmer());
    }

    if (state.coursesState.isFailure && state.courses.isEmpty) {
      return SliverToBoxAdapter(
        child: CoursesErrorView(
          message: state.errorMessage,
          onRetry: () => context.read<CoursesCubit>().loadCourses(),
        ),
      );
    }

    // Success — or failure with stale data still available
    return _CoursesListSliver(courses: state.courses);
  }
}

class _CoursesListSliver extends StatelessWidget {
  const _CoursesListSliver({required this.courses});

  final List courses;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverList.separated(
        itemCount: courses.length,

        separatorBuilder: (_, __) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseCard(
            code: course.shortname ?? 'N/A',
            title: course.fullname ?? 'Untitled',
            headerColor:
                AppColors.courseHeaderColors[index %
                    AppColors.courseHeaderColors.length],
            courseImage: course.courseimage,
            onTap: () {
              context.pushNamed(
                AppRouteNames.courseDetailsScreen,
                extra: course,
              );
            },
          );
        },
      ),
    );
  }
}
