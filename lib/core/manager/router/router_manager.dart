// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/auth/presentation/pages/forget_password/forget_password_screen.dart';
import 'package:netflix/features/auth/presentation/pages/reset_password/reset_password_screen.dart';

import 'package:netflix/features/auth/presentation/pages/signin/signin_screen.dart';
import 'package:netflix/features/auth/presentation/pages/signup/signup_screen.dart';
import 'package:netflix/features/auth/presentation/pages/verify_otp_code_reset/verify_otp_code_reset_screen.dart';
import 'package:netflix/features/auth/presentation/pages/welcome/welcome_screen.dart';
import 'package:netflix/features/download/presentation/pages/dwonload_screen.dart';
import 'package:netflix/features/explore/presentation/pages/explore_screen.dart';
import 'package:netflix/features/home/presentation/pages/home_screen.dart';
import 'package:netflix/features/movie/presentation/pages/movie_screen.dart';
import 'package:netflix/features/my_list/presentation/pages/my_list_screen.dart';
import 'package:netflix/features/nav_bar/presentation/nav_bar_screen.dart';
import 'package:netflix/features/onboarding/presentation/onboarding_screen.dart';
import 'package:netflix/features/payment/presentation/pages/payment_screen.dart';
import 'package:netflix/features/payment/presentation/pages/visa_screen.dart';
import 'package:netflix/features/plans/domain/entity/plan_entity.dart';
import 'package:netflix/features/plans/presentation/pages/plans_screen.dart';
import 'package:netflix/features/profile/presentation/pages/change_password_screen.dart';
import 'package:netflix/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:netflix/features/profile/presentation/pages/security_screen.dart';

import '../../../features/profile/presentation/pages/download_setting.dart';
import '../../../features/profile/presentation/pages/profile_screen.dart';
import '../../../features/payment/presentation/pages/paypal_screen.dart';
import '../../providers/user_local_provider.dart';

class AppRouteManager {
  AppRouteManager._();

  static dynamic router(GlobalKey<NavigatorState> shellNavigator) => [
        GoRoute(
          path: Routes.onBoardingScreen,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const OnBoardingScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.welcome,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const WelcomeScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.signUp,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const SignUpScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.signIn,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const SignInScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.forgetPassword,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const ForgetPasswordScreen(),
            );
          },
          routes: [
            GoRoute(
              path: Routes.verifyPassResetCode,
              name: Routes.verifyPassResetCode,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: VerifyOtpCodeResetScreen(
                    email: state.queryParameters["email"]!,
                  ),
                );
              },
            ),
            GoRoute(
              path: Routes.resetPassword,
              name: Routes.resetPassword,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: ResetPasswordScreen(
                    email: state.queryParameters["email"]!,
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.movie,
          name: Routes.movie,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: MovieScreen(
                image: state.extra as String,
                movieID: state.queryParameters["id"] as String,
              ),
            );
          },
        ),
        GoRoute(
          path: Routes.plans,
          name: Routes.plans,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const PlansScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.payment,
          name: Routes.payment,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: PaymentScreen(
                plan: state.extra as PlanEntity,
              ),
            );
          },
          routes: [
            GoRoute(
              path: Routes.paypal,
              name: Routes.paypal,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: PayPalScreen(
                    plan: state.extra as PlanEntity,
                  ),
                );
              },
            ),
            GoRoute(
              path: Routes.visa,
              name: Routes.visa,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: VisaScreen(
                    plan: state.extra as PlanEntity,
                  ),
                );
              },
            ),
          ],
        ),

        // bottom navigation bar
        ShellRoute(
          navigatorKey: shellNavigator,
          builder: (context, state, child) => NavBarScreen(
            key: state.pageKey,
            child: child,
          ),
          routes: [
            GoRoute(
              path: Routes.home,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: HomeScreen(
                    key: state.pageKey,
                  ),
                );
              },
            ),
            GoRoute(
              path: Routes.explore,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: ExploreScreen(
                    key: state.pageKey,
                  ),
                );
              },
            ),
            GoRoute(
              path: Routes.myList,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: MyListScreen(
                    key: state.pageKey,
                  ),
                );
              },
            ),
            GoRoute(
              path: Routes.download,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: DownloadScreen(
                    key: state.pageKey,
                  ),
                );
              },
            ),
            GoRoute(
              path: Routes.account,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: ProfileScreen(
                    key: state.pageKey,
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: Routes.editProfile,
                  name: Routes.editProfile,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const EditProfileScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: Routes.changePassword,
                  name: Routes.changePassword,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const ChangePasswordScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: Routes.downloadSetting,
                  name: Routes.downloadSetting,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const DownloadSettingScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: Routes.security,
                  name: Routes.security,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const SecurityScreen(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ];

  static String? redirect(Ref ref, GoRouterState state) {
    final isUserLoggedIn = ref.read(userLocalProvider);

    if (isUserLoggedIn != null) return Routes.welcome;
    if (isUserLoggedIn == null) return Routes.onBoardingScreen;

    return null;
  }
}
