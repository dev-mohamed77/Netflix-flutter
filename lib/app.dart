import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/manager/theme/theme_manager.dart';
import 'package:netflix/features/profile/presentation/manager/theme_mode_manager.dart';

import 'core/manager/router/go_router_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final router = ref.watch(goRouterProvider);
        final themeMode = ref.watch(themeModeManagerProvider);

        return MaterialApp.router(
          title: 'Netflix',
          debugShowCheckedModeBanner: false,
          // themeMode: ThemeMode.dark,
          themeMode: themeMode != null
              ? themeMode == true
                  ? ThemeMode.dark
                  : ThemeMode.light
              : ThemeMode.system,
          darkTheme: AppThemeManager.darkTheme,
          theme: AppThemeManager.lightTheme,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        );
      },
    );
  }
}
