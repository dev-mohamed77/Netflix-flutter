import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

import '../../../../../core/components/button_custom.dart';
import '../../../../../core/components/vertical_spacer.dart';
import '../../../data/model/movie_download_model.dart';
import '../../manager/providers.dart';

class DownloadBottomSheet extends ConsumerWidget {
  const DownloadBottomSheet({
    super.key,
    required this.data,
    required this.box,
    required this.index,
  });

  final MovieDownloadModel data;

  final Box<MovieDownloadModel> box;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteMovie = ref.watch(deleteMovieFromLocalStorageUseCaseProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Delete",
            style: TextStyle(
              color: context.accentColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalSpacer(15),
          Text(
            "Are you sure you want to delete this movie download?",
            textAlign: TextAlign.center,
            style: TextStyle(color: context.secondaryColor),
          ),
          const VerticalSpacer(40),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ButtonCustom(
                  title: deleteMovie.isLoading
                      ? const CircularProgressIndicator(
                          color: AppColorsManager.white,
                          strokeWidth: 3,
                        )
                      : const Text(
                          "Yes, Delete",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColorsManager.white,
                          ),
                        ),
                  onClick: () {
                    ref
                        .read(
                            deleteMovieFromLocalStorageUseCaseProvider.notifier)
                        .execute(
                          pathStream: data.streamUrl,
                          pathImage: data.image,
                        )
                        .then((_) {
                      box.deleteAt(index).then((_) {
                        context.pop();
                      });
                    });
                  },
                ),
              ),
            ],
          ),
          const VerticalSpacer(10),
        ],
      ),
    );
  }
}
