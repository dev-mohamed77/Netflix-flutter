import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/manager/dailog/dialog_custom.dart';
import 'package:netflix/features/download/presentation/manager/providers.dart';

import '../../../../../core/components/button_custom.dart';
import '../../../../../core/components/vertical_spacer.dart';
import '../../../../../core/manager/color/colors_manager.dart';

class DeleteAllMoviesBottomSheet extends ConsumerWidget {
  const DeleteAllMoviesBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteAllMovie =
        ref.watch(deleteAllMoviesFromLocalStorageUseCaseProvider);

    ref.listen(
      deleteAllMoviesFromLocalStorageUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: data.toString(),
              color: AppColorsManager.green,
            );
          },
          error: (error, stack) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColorsManager.red,
            );
          },
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Delete Movies",
            style: TextStyle(
              color: AppColorsManager.accentColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalSpacer(15),
          const Text(
            "Are you sure you want to delete these downloaded movies?",
            textAlign: TextAlign.center,
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
                  title: deleteAllMovie.isLoading
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
                        .read(deleteAllMoviesFromLocalStorageUseCaseProvider
                            .notifier)
                        .execute()
                        .then((_) {
                      context.pop();
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
