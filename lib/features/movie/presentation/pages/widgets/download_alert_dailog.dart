import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

import '../../../../../core/components/vertical_spacer.dart';
import '../../../../../core/manager/color/colors_manager.dart';
import '../../manager/providers.dart';

class DownloadAlertDialog extends ConsumerWidget {
  const DownloadAlertDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: const Text(
        "Download",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: AppColorsManager.accentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Movies still downloader ... \n Please wait or hide the process",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: context.secondaryColor,
            ),
          ),
          const VerticalSpacer(30),
          StreamBuilder<int>(
            stream: ref.read(downloadMovieProvider.notifier).downloadController,
            builder: (context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${snapshot.data} %",
                      style: const TextStyle(
                        color: AppColorsManager.accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Slider(
                      inactiveColor: AppColorsManager.grey,
                      value: snapshot.data!.toDouble(),
                      onChanged: (value) {},
                      min: 0,
                      max: 100,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const VerticalSpacer(20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text("Hide"),
            ),
          ),
        ],
      ),
    );
  }
}
