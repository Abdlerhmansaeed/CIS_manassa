import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

import '../widgets/profile_header.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../widgets/logout_button.dart';
import 'package:mansaa_app/features/home/presentation/widgets/home_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const HomeAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const ProfileHeader(
                  name: "Ahmed Mohamed",
                  studentId: "20210234",
                  imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuDDZdyF29Le1dmoSr8u__h967KF11LhJL3rgQA6cpWLqIrfRrrZljV5JpBsvGYrc1HcuuQ3zNysSY1R3TqBlEcrd-p3m4PdpWVQM32HlsNWozrdS8igArwahgjMkuLIhoNonAtmF7TxQjiCQvW7PXiyPg1ih-Al9WermXBxDe1djuZWbhwVmInUyxtGgkzXIQnLi1xnqNH3sjKrXhA2FIxKyiWQi43penDID-XToMLoFt7dso2tGHrWex7IaD9VPy2mQNBh0f4Xp_8q",
                  badgeLevel: "الفرقة الثالثة · CIS",
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      _buildPreferencesSection(context),
                      SizedBox(height: 32.h),
                      _buildAccountSection(context),
                      SizedBox(height: 16.h),
                      LogoutButton(
                        onTap: () {
                          // TODO: implement logout logic
                        },
                      ),
                      SizedBox(height: 40.h),
                      _buildFooter(context),
                    ],
                  ),
                ),
                SizedBox(height: 80.h), // padding for bottom navigation
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection(BuildContext context) {
    return SettingsSection(
      title: "التفضيلات",
      children: [
        SettingsTile(
          icon: Icons.language,
          title: "اللغة",
          trailing: _buildSegmentedControl(context, ["العربية", "English"], 0),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.light_mode,
          title: "المظهر",
          trailing: _buildSegmentedControl(context, ["فاتح ☀️", "داكن 🌙", "تلقائي"], 2, isCompact: true),
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
        SettingsTile(
          icon: Icons.format_size,
          title: "حجم الخط",
          trailing: _buildSegmentedControl(context, ["ص", "م", "ك"], 1, isCompact: true),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return SettingsSection(
      title: "الحساب",
      children: [
        SettingsTile(
          icon: Icons.badge,
          iconColor: Colors.blue.shade600,
          iconBackgroundColor: Colors.blue.shade100,
          title: "البيانات الأكاديمية",
          trailing: Icon(Icons.chevron_left, color: context.colors.onSurfaceVariant.withOpacity(0.5)),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.info,
          iconColor: context.colors.onSurfaceVariant,
          iconBackgroundColor: context.colors.surfaceContainerHighest,
          title: "عن التطبيق",
          subtitle: "الإصدار 1.0.0",
          trailing: Icon(Icons.chevron_left, color: context.colors.onSurfaceVariant.withOpacity(0.5)),
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.headphones,
          iconColor: Colors.teal.shade600,
          iconBackgroundColor: Colors.teal.shade50,
          title: "المساعدة والدعم",
          trailing: Icon(Icons.chevron_left, color: context.colors.onSurfaceVariant.withOpacity(0.5)),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          "CIS Student Hub · v1.0.0",
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: context.colors.onSurfaceVariant.withOpacity(0.5),
            letterSpacing: 1.5,
          ),
          textDirection: TextDirection.ltr,
        ),
        SizedBox(height: 4.h),
        Text(
          "كلية الحاسبات والمعلومات",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentedControl(BuildContext context, List<String> options, int selectedIndex, {bool isCompact = false}) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colors.outlineVariant.withOpacity(0.1)),
      ),
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          final isSelected = index == selectedIndex;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 12.w : 16.w, 
              vertical: isCompact ? 6.h : 8.h
            ),
            decoration: isSelected
                ? BoxDecoration(
                    color: context.colors.primaryContainer,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  )
                : null,
            child: Text(
              options[index],
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? context.colors.onPrimary : context.colors.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
          );
        }),
      ),
    );
  }
}
