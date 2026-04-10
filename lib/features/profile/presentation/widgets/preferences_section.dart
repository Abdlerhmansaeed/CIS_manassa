import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
import 'package:mansaa_app/core/languages/languages_manager.dart';
import 'package:mansaa_app/core/theme/theme_manager.dart';
import 'package:mansaa_app/core/extensions/localization_extension.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/segmented_control.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/settings_section.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/settings_tile.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: context.l10n.preferences,
      children: [
        SettingsTile(
          icon: Icons.language,
          title: context.l10n.language,
          trailing: SegmentedControl(
            options: context.read<LanguagesManager>().provideLanguages(),
            selectedIndex:
                context.read<LanguagesManager>().state.language == "ar" ? 0 : 1,
            onChanged: (index) {
              getIt<LanguagesManager>().changeLanguage(
                index == 0 ? "ar" : "en",
              );
            },
          ),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.light_mode,
          title: context.l10n.theme,
          trailing: BlocBuilder<ThemeManager, ThemeState>(
            bloc: context.read<ThemeManager>(),
            buildWhen: (previous, current) {
              return previous.themeMode != current.themeMode;
            },
            builder: (context, state) {
              int uiSelectedIndex;
              switch (state.themeMode) {
                case ThemeMode.light:
                  uiSelectedIndex = 0;
                  break;
                case ThemeMode.dark:
                  uiSelectedIndex = 1;
                  break;
                default:
                  uiSelectedIndex = 2;
              }

              return SegmentedControl(
                options: [
                  context.l10n.lightMode,
                  context.l10n.darkMode,
                  context.l10n.systemMode
                ],
                selectedIndex: uiSelectedIndex,
                isCompact: true,
                onChanged: (index) {
                  ThemeMode newMode;
                  switch (index) {
                    case 0:
                      newMode = ThemeMode.light;
                      break;
                    case 1:
                      newMode = ThemeMode.dark;
                      break;
                    default:
                      newMode = ThemeMode.system;
                  }
                  context.read<ThemeManager>().changeTheme(newMode);
                },
              );
            },
          ),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.notifications,
          title: context.l10n.notifications,
          subtitle: context.l10n.notificationsDescription,
          trailing: Switch(
            value: true,
            activeColor: context.colors.onPrimary,
            activeTrackColor: context.colors.primaryContainer,
            onChanged: (val) {},
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
