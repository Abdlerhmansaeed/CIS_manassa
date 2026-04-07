import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/di/di.dart';
import 'package:mansaa_app/core/manager/app_manager.dart';
import 'package:mansaa_app/core/helpers/app_bloc_observer.dart';
import 'package:mansaa_app/core/routing/app_router.dart';
import 'package:mansaa_app/core/theme/app_theme.dart';
import 'package:resposive_xx/responsive/responsive.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await configureDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      child: BlocProvider(
        create: (context) => getIt<AppManager>()..checkRememberMe(),
        child: MaterialApp.router(
          title: "Cis Manssaa",
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          // themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
