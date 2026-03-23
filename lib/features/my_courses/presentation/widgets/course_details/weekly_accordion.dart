import 'package:flutter/material.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/week_item.dart';

class WeeklyAccordion extends StatelessWidget {
  const WeeklyAccordion({super.key, required this.sections});

  final List<SectionModel> sections;

  @override
  Widget build(BuildContext context) {
    if (sections.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text('No contents available.')),
      );
    }

    return SliverList.separated(
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final section = sections[index];
        // final isInitiallyExpanded = index == 0;
        return WeekItem(
          section: section,
          isInitiallyExpanded: sections.last == section,
          isnew: sections.last == section,
          isCurrent: sections.last == section,
        );
      },
    );
  }
}
