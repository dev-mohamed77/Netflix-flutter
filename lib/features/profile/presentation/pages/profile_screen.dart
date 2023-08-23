import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/components/appbar_custom_section.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/providers/user_local_provider.dart';
import 'package:netflix/features/profile/presentation/pages/widgets/profile_items.dart';
import 'package:netflix/features/profile/presentation/pages/widgets/profile_plan_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpacer(15),
        const AppBarCustomSection(
          title: "Profile",
          isSearch: false,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacer(7),
                textSection(),
                const VerticalSpacer(30),
                const ProfilePlanSection(),
                const VerticalSpacer(30),
                const ProfileItems(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget textSection() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final user = ref.watch(userLocalProvider);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Hello, ${user?.fullName ?? ""}",
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
