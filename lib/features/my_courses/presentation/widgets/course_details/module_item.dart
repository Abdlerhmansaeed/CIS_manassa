import 'package:flutter/material.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_course_details_response/course_content_models.dart';

// ─── Module type enum ────────────────────────────────────────────────────────

enum _ModuleType { quiz, assignment, forum, resource }

extension _ModuleTypeX on String {
  _ModuleType get toModuleType => switch (toLowerCase()) {
    'quiz' => _ModuleType.quiz,
    'assign' => _ModuleType.assignment,
    'forum' => _ModuleType.forum,
    _ => _ModuleType.resource,
  };
}

// ─── ModuleItem ───────────────────────────────────────────────────────────────

class ModuleItem extends StatelessWidget {
  const ModuleItem({
    super.key,
    required this.module,
    this.isNew = false,
    this.onActionTap,
    this.onDownloadTap,
    this.onForumTap,
  });

  final ModuleModel module;

  /// Show the "NEW" badge on resource cards.
  final bool isNew;

  /// Called when the Quiz/Assignment action button is tapped.
  final VoidCallback? onActionTap;

  /// Called when the download icon on a resource card is tapped.
  final VoidCallback? onDownloadTap;

  /// Called when a forum card is tapped.
  final VoidCallback? onForumTap;

  _ModuleType get _type => module.modname.toModuleType;

  @override
  Widget build(BuildContext context) {
    return switch (_type) {
      _ModuleType.quiz => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: _HighlightedCard(
          module: module,
          typeLabel: 'QUIZ',
          accentColor: AppColors.primaryContainer,
          bgColor: AppColors.primarySurface,
          labelColor: AppColors.primaryContainer,
          actionText: 'Attempt →',
          actionBgColor: AppColors.primaryContainer,
          actionTextColor: Colors.white,
          onActionTap: onActionTap,
        ),
      ),
      _ModuleType.assignment => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: _HighlightedCard(
          module: module,
          typeLabel: 'ASSIGNMENT',
          accentColor: AppColors.amber,
          bgColor: AppColors.amberSurface,
          labelColor: AppColors.amberText,
          actionText: 'Submit →',
          actionBgColor: AppColors.amber,
          actionTextColor: Colors.black,
          onActionTap: onActionTap,
        ),
      ),
      _ModuleType.forum => _ForumCard(module: module, onTap: onForumTap),
      _ModuleType.resource => _ResourceCard(
        module: module,
        isNew: isNew,
        onDownloadTap: onDownloadTap,
      ),
    };
  }
}

// ─── Resource Card ────────────────────────────────────────────────────────────

class _ResourceCard extends StatelessWidget {
  const _ResourceCard({
    required this.module,
    required this.isNew,
    this.onDownloadTap,
  });

  final ModuleModel module;
  final bool isNew;
  final VoidCallback? onDownloadTap;

  IconData get _icon => switch (module.modname.toLowerCase()) {
    'url' => Icons.link,
    'page' => Icons.article_outlined,
    'label' => Icons.label_outline,
    'folder' => Icons.folder_outlined,
    'videotime' || 'video' => Icons.play_circle_outline,
    _ => Icons.picture_as_pdf,
  };

  @override
  Widget build(BuildContext context) {
    final fileCount = module.contents?.length ?? 0;

    return Row(
      children: [
        _CircleIcon(icon: _icon, color: AppColors.primaryContainer),
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
                  if (isNew) ...[const SizedBox(width: 8), const _NewBadge()],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Resource · $fileCount ${fileCount == 1 ? 'file' : 'files'}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onDownloadTap,
          icon: const Icon(Icons.download, color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}

// ─── Forum Card ───────────────────────────────────────────────────────────────

class _ForumCard extends StatelessWidget {
  const _ForumCard({required this.module, this.onTap});

  final ModuleModel module;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            _RoundedIcon(
              icon: Icons.campaign,
              color: Colors.blue.shade600,
              bgColor: Colors.blue.shade100,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Course forum',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.outline,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Highlighted Card (Quiz / Assignment) ─────────────────────────────────────

class _HighlightedCard extends StatelessWidget {
  const _HighlightedCard({
    required this.module,
    required this.typeLabel,
    required this.accentColor,
    required this.bgColor,
    required this.labelColor,
    required this.actionText,
    required this.actionBgColor,
    required this.actionTextColor,
    this.onActionTap,
  });

  final ModuleModel module;
  final String typeLabel;
  final Color accentColor;
  final Color bgColor;
  final Color labelColor;
  final String actionText;
  final Color actionBgColor;
  final Color actionTextColor;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            typeLabel,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: labelColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            module.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              _ActionButton(
                label: actionText,
                bgColor: actionBgColor,
                textColor: actionTextColor,
                onTap: onActionTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Small reusable sub-widgets ───────────────────────────────────────────────

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withAlpha(26), // ~10% opacity
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }
}

class _RoundedIcon extends StatelessWidget {
  const _RoundedIcon({
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  final IconData icon;
  final Color color;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'NEW',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.bgColor,
    required this.textColor,
    this.onTap,
  });

  final String label;
  final Color bgColor;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: bgColor.withAlpha(51), // ~20% shadow
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
