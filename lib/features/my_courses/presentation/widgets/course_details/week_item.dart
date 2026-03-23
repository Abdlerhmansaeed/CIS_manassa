import 'package:flutter/material.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';
import 'package:mansaa_app/features/my_courses/presentation/widgets/course_details/module_item.dart';

class WeekItem extends StatefulWidget {
  const WeekItem({
    super.key,
    required this.section,
    required this.isInitiallyExpanded,
  });

  final SectionModel section;
  final bool isInitiallyExpanded;

  @override
  State<WeekItem> createState() => _WeekItemState();
}

class _WeekItemState extends State<WeekItem> {
  late bool _isExpanded;


  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    // If there are no modules, we might just show it locked or completed.
    final hasModules = widget.section.modules.isNotEmpty;
    // For styling purposes based on the HTML
    final isCurrent = _isExpanded;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: isCurrent
            ? const Color(0xFFFFFFFF) // surface-container-lowest
            : const Color(0xFFFBF2E8), // surface-container-low
        borderRadius: BorderRadius.circular(8.0),
        border: isCurrent
            ? const Border(left: BorderSide(color: Color(0xFFC8191A), width: 4))
            : null,
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha(8),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            tilePadding: const EdgeInsets.all(20.0),
            title: Row(
              children: [
                if (!isCurrent)
                  Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isCurrent) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC8191A).withAlpha(26),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Text(
                            'CURRENT WEEK',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFC8191A),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.section.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Plus Jakarta Sans',
                          ),
                        ),
                      ] else ...[
                        Text(
                          widget.section.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${widget.section.modules.length} modules',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5C403C),
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            childrenPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            children: [
              if (hasModules)
                ...widget.section.modules.map(
                  (module) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ModuleItem(module: module),
                  ),
                )
              else
                const Text(
                  'No modules available for this week.',
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
