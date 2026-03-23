import 'package:flutter/material.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';

class ModuleItem extends StatelessWidget {
  const ModuleItem({
    super.key,
    required this.module,
  });

  final ModuleModel module;

  @override
  Widget build(BuildContext context) {
    final modname = module.modname.toLowerCase();

    if (modname == 'quiz' || modname == 'assign') {
      return _buildHighlightedCard(
        title: module.name,
        typeLabel: modname == 'quiz' ? 'QUIZ' : 'ASSIGNMENT',
        color: modname == 'quiz' ? const Color(0xFFC8191A) : const Color(0xFFFFC107),
        bgColor: modname == 'quiz' ? const Color(0xFFFFF5F5) : const Color(0xFFFFFBF0),
        textColor: modname == 'quiz' ? const Color(0xFFC8191A) : const Color(0xFF795548),
        actionText: modname == 'quiz' ? 'Attempt →' : 'Submit →',
        actionBgColor: modname == 'quiz' ? const Color(0xFFC8191A) : const Color(0xFFFFC107),
        actionTextColor: modname == 'quiz' ? Colors.white : Colors.black,
      );
    } else if (modname == 'forum') {
      return _buildForumCard();
    } else {
      return _buildResourceCard();
    }
  }

  Widget _buildResourceCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF2E8), // surface-container-low
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8191A).withAlpha(26),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: Color(0xFFC8191A),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              module.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC8191A),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              'NEW',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Resource · ${module.contents?.length ?? 0} files',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5C403C), // on-surface-variant
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.download,
              color: Color(0xFF5C403C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForumCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF2E8), // surface-container-low
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.campaign,
                  color: Colors.blue.shade600,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Course forum',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5C403C),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF916F6B), // outline
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedCard({
    required String title,
    required String typeLabel,
    required Color color,
    required Color bgColor,
    required Color textColor,
    required String actionText,
    required Color actionBgColor,
    required Color actionTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      typeLabel,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Check dates inside',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5C403C),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: actionBgColor,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: [
                    BoxShadow(
                      color: actionBgColor.withAlpha(51),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: actionTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
