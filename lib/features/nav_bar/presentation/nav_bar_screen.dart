import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/providers/token_local_provider.dart';
import 'package:netflix/features/nav_bar/presentation/widgets/bottom_navigation_bar_custom.dart';

import '../../../core/manager/dailog/dialog_custom.dart';
import '../../../core/manager/router/routes.dart';
import '../../auth/presentation/manager/providers.dart';

class NavBarScreen extends ConsumerWidget {
  final Widget child;
  const NavBarScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _userListen(ref, context);

    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavigationBarCustom(),
    );
  }

  _userListen(WidgetRef ref, BuildContext context) {
    ref.listen(getUserByTokenUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          final membershipStartDate = data?.membershipStartDate;
          final membershipEndDate = data?.membershipEndDate;

          if ((membershipStartDate == "" || membershipStartDate == null) ||
              (membershipEndDate == "" || membershipEndDate == null)) {
            context.goNamed(Routes.plans);
          } else {
            // compare DateTime.now() with membershipEndDate
            final isEndMember = DateTime.now().isBefore(
              DateTime.parse(membershipEndDate),
            );

            if (!isEndMember) {
              context.pushReplacementNamed(Routes.plans);
            }
          }
        },
        error: (error, stackTrace) {
          if (error.toString() == "Unauthorized") {
            DialogCustom.showSnackBar(context, message: error.toString())
                .then((_) {
              context.pushReplacement(Routes.signIn);
              ref.read(tokenLocalProvider.notifier).setNull();
            });
          }
          DialogCustom.showSnackBar(context, message: error.toString());
        },
      );
    });
  }
}
