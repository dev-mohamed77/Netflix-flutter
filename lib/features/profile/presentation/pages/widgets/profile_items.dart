import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/profile/presentation/manager/profile_data_provider.dart';
import 'package:netflix/features/profile/presentation/manager/theme_mode_manager.dart';

class ProfileItems extends ConsumerWidget {
  const ProfileItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataList = ref.watch(profileDataProvider);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 3),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final data = dataList[index];

        if (index == 4) {
          return SwitchListTile(
            secondary: Icon(data["icon"] as IconData),
            title: Text(
              "${data["title"]}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: (value) {
              ref
                  .read(themeModeManagerProvider.notifier)
                  .selectThemeState(value);
            },
            value: ref.watch(themeModeManagerProvider) ?? false,
          );
        }

        return ListTile(
          onTap: () async {
            if (data["title"] == "Edit Profile") {
              context.goNamed(Routes.editProfile);
            } else if (data["title"] == "Change Password") {
              context.goNamed(Routes.changePassword);
            } else if (data["title"] == "Download") {
              context.goNamed(Routes.downloadSetting);
            } else if (data["title"] == "Security") {
              context.goNamed(Routes.security);
            }
          },
          leading: Icon(
            data["icon"] as IconData,
          ),
          title: Text("${data["title"]}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        );
      },
    );
  }
}
