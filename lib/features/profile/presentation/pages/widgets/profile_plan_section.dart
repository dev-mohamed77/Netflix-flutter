import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';

import '../../../../../core/manager/color/colors_manager.dart';
import '../../../../../core/providers/user_local_provider.dart';

class ProfilePlanSection extends ConsumerWidget {
  const ProfilePlanSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userLocalProvider);

    if (user?.membership == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: context.width,
      height: context.height * 0.13,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 2,
          color: AppColorsManager.accentColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            const Icon(
              FontAwesomeIcons.crown,
              color: AppColorsManager.accentColor,
              fill: 0,
              size: 45,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user!.membership.title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColorsManager.accentColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    user.membership.description,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColorsManager.accentColor,
            )
          ],
        ),
      ),
    );
  }
}
