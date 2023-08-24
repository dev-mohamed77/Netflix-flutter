import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/manager/router/router_manager.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/core/providers/token_local_provider.dart';
import 'package:netflix/features/auth/presentation/manager/providers.dart';

import 'global_navigator_key.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final token = ref.watch(tokenLocalProvider);
  ref.read(getUserByTokenUseCaseProvider.notifier).execute();
  return GoRouter(
    initialLocation: token != null ? Routes.home : Routes.onBoardingScreen,
    navigatorKey: GlobalNavigatorKey.rootNavigator,
    routes: AppRouteManager.router(GlobalNavigatorKey.shellNavigator),
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // final isToken = ref.read(tokenLocalProvider);

      // print(
      //     "areWeLoggingIn =========>>>>>>>>>>>>>>>>>>>> ${state.location == Routes.home}");

      // if (isToken != null) return Routes.home;
      // if (isToken == null) return Routes.signIn;

      // print(
      //     "isUserLoggedIn =========>>>>>>>>>>>>>>>>>>>> ${isUserLoggedIn == null}");

      // if (isUserLoggedIn != null) return Routes.onBoardingScreen;
      // if (isUserLoggedIn == null) return Routes.welcome;

      return null;
    },
  );
});
