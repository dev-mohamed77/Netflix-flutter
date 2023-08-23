import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/router/routes.dart';

import '../manager/navigation_bar_notifier.dart';

class BottomNavigationBarCustom extends ConsumerWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navigationBarProvider);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            _onTap(value, ref: ref, ctx: context);
          },
          selectedItemColor: AppColorsManager.accentColor,
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
          unselectedItemColor: AppColorsManager.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
              label: "Explore",
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              tooltip: "Explore",
            ),
            BottomNavigationBarItem(
              label: "My List",
              icon: Icon(Icons.favorite_border_outlined),
              activeIcon: Icon(Icons.favorite),
              tooltip: "My List",
            ),
            BottomNavigationBarItem(
              label: "Download",
              icon: Icon(Icons.downloading_outlined),
              activeIcon: Icon(Icons.downloading),
              tooltip: "Download",
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person_2_outlined),
              activeIcon: Icon(Icons.person_2),
              tooltip: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  _onTap(
    int index, {
    required WidgetRef ref,
    required BuildContext ctx,
  }) {
    ref.read(navigationBarProvider.notifier).select(index);
    switch (index) {
      case 0:
        ctx.go(Routes.home);
        break;
      case 1:
        ctx.go(Routes.explore);
        break;
      case 2:
        ctx.go(Routes.myList);
        break;
      case 3:
        ctx.go(Routes.download);
        break;
      case 4:
        ctx.go(Routes.account);
        break;
    }
  }
}
