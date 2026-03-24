import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/presentation/cubit/courses_cubit.dart';
import 'package:mansaa_app/features/my_courses/presentation/cubit/courses_state.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/course_hero_card.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/course_tabs_bar.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/weekly_accordion.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key, required this.course});

  final StudentCourseResponse course;

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with TickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late final ScrollController scrollController;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _selectedTabIndex = _tabController.index);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // API call
      if (widget.course.id != null) {
        context.read<CoursesCubit>().getCourseDetails(
          courseId: widget.course.id!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // scaffold background
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainer.withOpacity(0.8),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Course Detail',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryContainer),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.primaryContainer,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<CoursesCubit, CoursesState>(
        listener: (context, state) {
          if (state.courseContentsState == AppStates.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent + 1000,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        },
        builder: (context, state) {
          if (state.courseContentsState == AppStates.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryContainer,
              ),
            );
          }

          if (state.courseContentsState == AppStates.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Failed to load course details',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final sections = state.courseContents;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: CourseHeroCard(course: widget.course),
                ),
                SliverToBoxAdapter(child: const SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: CourseTabsBar(
                    selectedIndex: _selectedTabIndex,
                    tabController: _tabController,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                if (_selectedTabIndex == 0) ...[
                  WeeklyAccordion(sections: sections),
                ] else ...[
                  const SliverToBoxAdapter(
                    child: Center(child: Text('Grades Content Placeholder')),
                  ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          );
        },
      ),
    );
  }
}
