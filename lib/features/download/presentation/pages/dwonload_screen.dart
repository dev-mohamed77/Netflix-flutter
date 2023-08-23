import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netflix/core/manager/dailog/dialog_custom.dart';
import 'package:netflix/core/service/local_service/shared_keys.dart';
import 'package:netflix/features/download/data/model/movie_download_model.dart';
import 'package:netflix/features/download/presentation/manager/providers.dart';
import 'package:netflix/features/download/presentation/pages/widgets/download_bottom_sheet.dart';
import 'package:netflix/features/download/presentation/pages/widgets/download_item.dart';

import '../../../../core/components/appbar_custom_section.dart';
import '../../../../core/components/no_data.dart';
import '../../../../core/components/vertical_spacer.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      deleteMovieFromLocalStorageUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "The movie has been successfully deleted",
              color: Colors.green,
            );
          },
          error: (error, stackTrace) {
            DialogCustom.showSnackBar(
              context,
              message: "An error occurred while deleting the movie",
            );
          },
        );
      },
    );

    return Column(
      children: [
        const VerticalSpacer(15),
        AppBarCustomSection(
          title: 'Download',
          onClick: () {},
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable:
                Hive.box<MovieDownloadModel>(SharedPrefKeys.downloadMovieKey)
                    .listenable(),
            builder: (context, value, _) {
              if (value.isEmpty) {
                return const NoData(
                  description:
                      "it seems that you haven't added any movies to the list",
                  title: 'Your List is Empty',
                );
              }
              return ListView.separated(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final data = value.getAt(index);

                  return DownloadItem(
                    data: data!,
                    onClickDelete: () {
                      DialogCustom.showModelBottomSheetCustom(
                        context,
                        child: DownloadBottomSheet(
                          box: value,
                          data: data,
                          index: index,
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const VerticalSpacer(15);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
