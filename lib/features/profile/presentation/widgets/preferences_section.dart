import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
import 'package:mansaa_app/core/manager/app_manager.dart';
import 'package:mansaa_app/core/manager/app_manager_state.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/segmented_control.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/settings_section.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/settings_tile.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: "التفضيلات",
      children: [
        SettingsTile(
          icon: Icons.language,
          title: "اللغة",
          trailing: SegmentedControl(
            options: const ["العربية", "English"],
            selectedIndex: 0,
            onChanged: (index) {
              // TODO: Implement language change
            },
          ),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.light_mode,
          title: "المظهر",
          trailing: BlocBuilder<AppManager, AppManagerState>(
            builder: (context, state) {
              // Mapping UI index to ThemeMode
              // UI Index: 0 -> Light, 1 -> Dark, 2 -> System
              // ThemeMode: light -> 1, dark -> 2, system -> 0
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
                options: const ["فاتح ☀️", "داكن 🌙", "تلقائي"],
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
                  context.read<AppManager>().changeTheme(newMode);
                },
              );
            },
          ),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.notifications,
          title: "الإشعارات",
          subtitle: "تذكير المهام والكويزات",
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
