import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/profile/presentation/manager/download_manager.dart';
import 'package:netflix/features/profile/presentation/pages/widgets/delete_all_movies_bottom_sheet.dart';

import '../../../../../core/manager/dailog/dialog_custom.dart';

class DownloadSettingBody extends StatelessWidget {
  const DownloadSettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            return SwitchListTile(
              secondary: const Icon(Icons.wifi),
              title: const Text(
                "Wi-Fi Only",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: ref.watch(downloadManagerProvider) ?? true,
              onChanged: (bool val) async {
                await ref.watch(downloadManagerProvider.notifier).select(val);
              },
            );
          },
        ),
        _listTileText(
          title: "Delete All Downloads",
          icon: Icons.delete_outline,
          onTap: () {
            DialogCustom.showModelBottomSheetCustom(
              context,
              child: const DeleteAllMoviesBottomSheet(),
            );
          },
        ),
        _listTileText(
          title: "Delete Cache",
          icon: Icons.delete_outline,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _listTileText({
    required String title,
    required IconData icon,
    void Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
