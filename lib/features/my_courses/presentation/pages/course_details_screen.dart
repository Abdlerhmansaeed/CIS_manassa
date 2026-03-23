import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';
import 'package:mansaa_app/features/my_courses/presentation/cubit/courses_cubit.dart';
import 'package:mansaa_app/features/my_courses/presentation/cubit/courses_state.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/course_hero_card.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/course_tabs_bar.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/weekly_accordion.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({
    super.key,
    required this.course,
  });

  final StudentCourseResponse course;

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.course.id != null) {
        context.read<CoursesCubit>().getCourseDetails(courseId: widget.course.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2), // scaffold background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5EDE3).withOpacity(0.8),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Course Detail',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1B15),
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC8191A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFFC8191A)),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          if (state.courseContentsState == AppStates.loading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFC8191A)));
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

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseHeroCard(course: widget.course),
                const SizedBox(height: 24),
                CourseTabsBar(
                  selectedIndex: _selectedTabIndex,
                  onTabSelected: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 24),
                if (_selectedTabIndex == 0) ...[
                  WeeklyAccordion(sections: sections),
                ] else if (_selectedTabIndex == 1) ...[
                  const Center(child: Text('Quizzes Content Placeholder')),
                ] else ...[
                  const Center(child: Text('Grades Content Placeholder')),
                ],
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}