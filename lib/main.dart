import 'package:flutter/material.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/routing/app_router.dart';
import 'package:mansaa_app/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Cis Manssaa",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      themeMode: ThemeMode.system,
    );
  }
}
