import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/network/session/user_session.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/account_management_section.dart';
import 'package:mansaa_app/features/profile/presentation/widgets/preferences_section.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
import '../widgets/profile_header.dart';
import '../widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          // const HomeAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const ProfileHeader(
                  name: "Ahmed Mohamed",
                  studentId: "20210234",
                  imageUrl:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuDDZdyF29Le1dmoSr8u__h967KF11LhJL3rgQA6cpWLqIrfRrrZljV5JpBsvGYrc1HcuuQ3zNysSY1R3TqBlEcrd-p3m4PdpWVQM32HlsNWozrdS8igArwahgjMkuLIhoNonAtmF7TxQjiCQvW7PXiyPg1ih-Al9WermXBxDe1djuZWbhwVmInUyxtGgkzXIQnLi1xnqNH3sjKrXhA2FIxKyiWQi43penDID-XToMLoFt7dso2tGHrWex7IaD9VPy2mQNBh0f4Xp_8q",
                  badgeLevel: "الفرقة الثالثة · CIS",
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      const PreferencesSection(),
                      SizedBox(height: 32.h),
                      const AccountManagementSection(),
                      SizedBox(height: 16.h),
                      LogoutButton(
                        onTap: () {
                          getIt<UserSession>().clearSession().then((value) {
                            if (context.mounted) {
                              context.pushReplacementNamed(AppRouteNames.login);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
