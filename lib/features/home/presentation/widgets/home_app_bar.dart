import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 70.h,
      collapsedHeight: 70.h,
      backgroundColor: context.colors.surfaceContainer.withOpacity(0.8),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.transparent),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.surfaceContainerHighest,
                  border: Border.all(
                    color: context.colors.primary.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.person,
                    color: context.colors.primary,
                    size: 24.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CIS Student Hub',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: context.colors.primaryContainer,
                    ),
                  ),
                  // Text(
                  //   'AHMED\'S PORTAL',
                  //   style: TextStyle(
                  //     fontSize: 10.sp,
                  //     fontWeight: FontWeight.w800,
                  //     letterSpacing: 1.5,
                  //     color: context.colors.onSurfaceVariant.withOpacity(0.7),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              context.pushNamed(AppRouteNames.notifications);
            },
            icon: Badge(
              label: const Text("1"),
              alignment: Alignment.topRight,
              largeSize: 16.sp,
              child: Icon(
                Icons.notifications_none_outlined,
                color: context.colors.primaryContainer,
                size: 28.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
