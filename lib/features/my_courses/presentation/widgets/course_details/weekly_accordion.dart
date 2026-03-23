import 'package:flutter/material.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/week_item.dart';

class WeeklyAccordion extends StatelessWidget {
  const WeeklyAccordion({
    super.key,
    required this.sections,
  });

  final List<SectionModel> sections;

  @override
  Widget build(BuildContext context) {
    if (sections.isEmpty) {
      return const Center(child: Text('No contents available.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        // For demonstration, let's treat the first section with modules as expanded
        final isInitiallyExpanded = index == 0; 
        return WeekItem(
          section: section,
          isInitiallyExpanded: isInitiallyExpanded,
        );
      },
    );
  }
}
