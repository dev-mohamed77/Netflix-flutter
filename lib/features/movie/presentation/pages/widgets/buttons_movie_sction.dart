// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import 'package:netflix/features/movie/presentation/pages/widgets/download_alert_dailog.dart';
import '../../../../../core/components/elevated_button_icon_custom.dart';
import '../../../../../core/components/outline_button_icon_custom.dart';
import '../../../../../core/manager/color/colors_manager.dart';
import '../../../../../core/manager/dailog/dialog_custom.dart';
import '../../../../video_player/presentation/video_player_network.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../manager/providers.dart';

class ButtonsMovieSection extends ConsumerWidget {
  const ButtonsMovieSection({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieEntity movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.width / 2.23,
            child: ElevatedButtonIconCustom(
              title: "Play",
              icon: Icons.play_arrow_rounded,
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerNetworkScreen(
                      videoUrl: movie.streamUrl,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: context.width / 2.23,
            child: OutLineButtonIconCustom(
              title: "Download",
              icon: Icons.download,
              onClick: () {
                ref.read(downloadMovieProvider.notifier).execute(movie: movie);

                DialogCustom.showDialogCustom(
                  context,
                  barrierDismissible: false,
                  child: const DownloadAlertDialog(),
                );
              },
              colorSide: AppColorsManager.accentColor,
              iconColor: AppColorsManager.accentColor,
              textColor: AppColorsManager.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
