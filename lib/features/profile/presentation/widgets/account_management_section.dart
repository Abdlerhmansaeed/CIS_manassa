import 'package:flutter/material.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
import 'package:mansaa_app/core/extensions/localization_extension.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/settings_section.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/settings_tile.dart';

class AccountManagementSection extends StatelessWidget {
  const AccountManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: context.l10n.account,
      children: [
        SettingsTile(
          icon: Icons.badge,
          iconColor: Colors.blue.shade600,
          iconBackgroundColor: Colors.blue.shade100,
          title: context.l10n.academicData,
          trailing: Icon(
            Icons.chevron_left,
            color: context.colors.onSurfaceVariant.withOpacity(0.5),
          ),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.info,
          iconColor: context.colors.onSurfaceVariant,
          iconBackgroundColor: context.colors.surfaceContainerHighest,
          title: context.l10n.aboutApp,
          subtitle: context.l10n.appVersion("1.0.0"),
          trailing: Icon(
            Icons.chevron_left,
            color: context.colors.onSurfaceVariant.withOpacity(0.5),
          ),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.headphones,
          iconColor: Colors.teal.shade600,
          iconBackgroundColor: Colors.teal.shade50,
          title: context.l10n.helpSupport,
          trailing: Icon(
            Icons.chevron_left,
            color: context.colors.onSurfaceVariant.withOpacity(0.5),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
